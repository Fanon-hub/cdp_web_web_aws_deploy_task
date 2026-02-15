class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]

  # catch problems communicating with the storage service so the user sees a friendly
  # message instead of a 500 error page when an upload or variant generation fails.
  # The `Aws::S3::Errors::ServiceError` class is a catch‑all for anything that goes
  # wrong talking to S3 (access denied, network outage, etc.). We also handle the
  # same two ActiveStorage-specific exceptions that the generator scaffolded.
  rescue_from ActiveStorage::IntegrityError, with: :storage_error
  rescue_from ActiveStorage::FileNotFoundError, with: :storage_error
  rescue_from Aws::S3::Errors::ServiceError, with: :storage_error


  # GET /blogs or /blogs.json
  def index
    @blogs = Blog.all
  end

  # GET /blogs/1 or /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs or /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:title, :content, :thumbnail)
    end

    # render a user‑friendly error if the storage backend rejects the file or
    # we cannot access the blob.  This covers both S3 failures and variant
    # processing errors.
    def storage_error(exception)
      Rails.logger.error "ActiveStorage error: \\#{exception.class} - \\#{exception.message}"
      flash[:alert] = "There was a problem with the file upload or processing. Please try again."
      if action_name == 'create'
        render :new, status: :unprocessable_entity
      else
        render :edit, status: :unprocessable_entity
      end
    end
end
