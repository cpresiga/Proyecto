class ChallengesController < ApplicationController
  
  require 'net/http'
  require 'uri'
  require 'json'

  $output = ''
  $language = ''
  $sourcode = ''
  
  before_action :authetificate_user!
  before_action :get_topic
  before_action :get_course
  before_action :set_challenge, only: %i[ show edit update destroy]

  # GET /challenges or /challenges.json
  def index
    @challenge = @topic.challenges
  end

  # GET /challenges/1 or /challenges/1.json
  def show
    @url = ("/courses/"+@course.id.to_s+"/topics/"+@topic.id.to_s+"/challenges/"+@challenge.id.to_s+"/challenge_submit")
    @output = $output
    @language = $language
    @sourcode = $sourcode    
    if ( ChallengeLog.find_by( challenge_id: params[:id]) and ChallengeLog.find_by(user_id: return_user.id) )
      @challenge_status = true
      @challange_result = ChallengeLog.find_by( challenge_id: params[:id])
      flash[:notice] = "Ya superastes este reto"
    else
      @challenge_status = false
    end

  end

  # GET /challenges/new
  def new
    @challenge = @topic.challenges.build
  end

  # GET /challenges/1/edit
  def edit
  end

  # POST /challenges or /challenges.json
  def create
    @challenge = @topic.challenges.build(challenge_params)

    respond_to do |format|
      if @challenge.save
        format.html { redirect_to course_topic_path(@course, @topic), notice: "Challenge was successfully created." }
        format.json { render :show, status: :created, location: @challenge }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /challenges/1 or /challenges/1.json
  def update
    respond_to do |format|
      if @challenge.update(challenge_params)
        format.html { redirect_to course_topic_challenge_path(@course, @topic, @challenge), notice: "Challenge was successfully updated." }
        format.json { render :show, status: :ok, location: @challenge }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenges/1 or /challenges/1.json
  def destroy
    @challenge.destroy
    respond_to do |format|
      format.html { redirect_to course_path(@course), notice: "Challenge was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def challenge_submit

    @challenge = Challenge.find(params[:challenge_id])
    code = params[:code]
    lenguaje = params[:lenguaje]
         
    uri = URI.parse("https://codexweb.netlify.app/.netlify/functions/enforceCode")
    request = Net::HTTP::Post.new(uri)
    request.body = JSON.dump({
      "code" => code,
      "language" => lenguaje,
      "input" => ""
    })

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    result = JSON.parse(response.body)

    puts response.body
    output = result["output"]
    output = output.to_s
    output = output.strip
    challenge_output = @challenge.output

    $output = result["output"]
    if ( result["language"] == 'cpp' ) 
      $language = 'C++'
    elsif ( result["language"] == 'c' ) 
      $language = 'C'
    elsif ( result["language"] == 'cs' ) 
      $language = 'C#'
    elsif ( result["language"] == 'java' ) 
      $language = 'Java'
    elsif ( result["language"] == 'py' ) 
      $language = 'Python'
    elsif ( result["language"] == 'rb' ) 
      $language = 'Ruby'
    elsif ( result["language"] == 'kt' ) 
      $language = 'Kotlin'
    elsif ( result["language"] == 'swift' ) 
      $language = 'Swift'
    end
    $sourcode = result["sourceCode"]

    if (output == challenge_output)

      @challenge_log = ChallengeLog.new
      @challenge_log.sourcode = result["sourceCode"]
      @challenge_log.status = result["status"]
      @challenge_log.errorCode = result["errorCode"]
      @challenge_log.error = result["error"]
      @challenge_log.output = result["output"]
      if ( result["language"] == 'cpp' ) 
        @challenge_log.language =  'C++'
      elsif ( result["language"] == 'c' ) 
        @challenge_log.language =  'C'
      elsif ( result["language"] == 'cs' ) 
        @challenge_log.language =  'C#'
      elsif ( result["language"] == 'java' ) 
        @challenge_log.language =  'Java'
      elsif ( result["language"] == 'py' ) 
        @challenge_log.language =  'Python'
      elsif ( result["language"] == 'rb' ) 
        @challenge_log.language =  'Ruby'
      elsif ( result["language"] == 'kt' ) 
        @challenge_log.language =  'Kotlin'
      elsif ( result["language"] == 'swift' ) 
        @challenge_log.language =  'Swift'
      end
      @challenge_log.challenge_id = @challenge.id
      @challenge_log.user_id = return_user.id

      if @challenge_log.save
        redirect_back(fallback_location: root_path)
        flash[:notice] = "Very good!"
      else
        redirect_back(fallback_location: root_path)
        flash[:notice] = "Ocurrio un error de nuevo"
      end
    else
        redirect_back(fallback_location: root_path)
        flash[:notice] = "Al parecer tienes un error en tu logica"
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
  
    def get_topic
      @topic = Topic.find(params[:topic_id])
    end

    def get_course
      @course = Course.find(@topic.course_id)
    end
    
    def set_challenge
      @challenge = @topic.challenges.find(params[:id])
    end


    # Only allow a list of trusted parameters through.
    def challenge_params
      params.require(:challenge).permit(:name, :challenge_description, :output_description, :output)
    end
end
