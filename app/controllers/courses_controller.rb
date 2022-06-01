class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1 or /courses/1.json
  def show
    @course_video_url = "https://www.youtube.com/embed/" + @course.video_url
    @pagy, @course_topic = pagy(@course.topics.order(created_at: :asc), items: 3)

    @success = 0
    @no_success = 0
    @topic_status = ''
    @sum = 0
    @prom = 0
    if (user_signed_in?)
      if ( !@course.topics.empty? )
        for topic in @course.topics
          if (TopicLog.find_by( topic_id: topic.id ) and TopicLog.find_by(user_id: return_user.id))
            @success = @success + 1
            @sum = @sum + 1
          else
            @no_success = @no_success +1
            @sum = @sum + 1
          end
        end
        
        if ( @sum == @success )
          @topic_status = true
        else
          @topic_status = false
        end

        @prom = (@success.to_f / (@success + @no_success).to_f) * 100
      end
    end
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)
    respond_to do |format|
      if @course.save
        if !@course.course_logo.attached?
          @course.course_logo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'defauld-icon-course.png')), filename: 'default-image-course.png', content_type: 'image/jpg ')
        end
        format.html { redirect_to @course, notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:name, :description, :video_url, :short_description, :level, :category, :video_url, :hours, :labels, :teacher_name, :teacher_description, :course_logo )
    end
end
