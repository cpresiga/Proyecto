class TopicsController < ApplicationController

  before_action :set_topic, only: %i[ edit update destroy ]
  before_action :get_course,

  # GET /topics or /topics.json
  def index
    @topics = @course.topics
  end

  # GET /topics/1 or /topics/1.json
  def show
    @topic = Topic.find params[:id]
    @topic_video_url = "https://www.youtube.com/embed/" + @topic.video_url
    @bandera = ''
    @success = 0
    @no_success = 0
    @prom = 0

    if (user_signed_in?)
      for challenge in @topic.challenges
        if  (ChallengeLog.find_by( challenge_id: challenge.id ) and ChallengeLog.find_by(user_id: return_user.id))
          @bandera = true
        else
          @bandera = false
          break
        end
      end

      for challenge in @topic.challenges
        if  (ChallengeLog.find_by( challenge_id: challenge.id ) and ChallengeLog.find_by(user_id: return_user.id))
          @success = @success + 1
        else
          @no_success = @no_success + 1
        end
      end
      @prom = (@success.to_f / (@success + @no_success).to_f) * 100

      if ( @bandera == true )
          if !(TopicLog.find_by(user_id: return_user.id) and TopicLog.find_by(topic_id: @topic.id))
          @topic_log = TopicLog.new
          @topic_log.course_id = @course.id
          @topic_log.user_id = current_user.id
          @topic_log.topic_id = @topic.id
          @topic_log.save
        end
      end
    end
  end

  # GET /topics/new
  def new
    @topic = @course.topics.build
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics or /topics.json
  def create
    @topic = @course.topics.build(topic_params)
    respond_to do |format|  
      if @topic.save
        format.html { redirect_to course_path(@course), notice: "Topic was successfully created." }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1 or /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to course_path(@course)  , notice: "Topic was successfully updated." }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1 or /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to course_path(@course), notice: "Topic was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def topic_params
      params.require(:topic).permit(:title, :video_url, :topic_notes, :about_topic, :labels)
    end

    def get_course
      @course = Course.find(params[:course_id])
    end
end
