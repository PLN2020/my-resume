class PostsController < ApplicationController
    before_action :require_login, except: [:show]
    before_action :find_post, only: [:show, :edit, :update, :destroy]
    
    def index
      @posts = policy_scope(Post).order(created_at: :desc)
    end
  
    def show
      @created_at = @post.created_at
      @updated_at = @post.updated_at
      authorize @post
    end
  
    def new
      @post = Post.new
      authorize @post
    end
  
    def create
      @post = Post.new(post_params)
      @post.user = current_user
      if @post.save
        redirect_to posts_path(@post)
      else
        render :new
      end
      authorize @post
    end
  
    def edit
    end
  
    def update
      @post.update(post_params)
      redirect_to post_path(@post)
      authorize @post
    end
  
    def destroy
      @post.destroy
      redirect_to posts_path
    end
  
    private
  
    def post_params
      params.require(:post).permit(:title, :content, :private, :photo)
    end
  
    def find_post
      @post = Post.find(params[:id])
      authorize @post
    end
  
    def require_login
      unless current_user
        redirect_to new_user_session_path
      end
    end
end
