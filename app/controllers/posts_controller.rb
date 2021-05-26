class PostsController < ApplicationController
    before_action :require_login, except: [:show]
    before_actiong :find_post
    
    def index
      @posts = policy_scope(Post).order(created_at: :desc)
    end
  
    def show
      authorize @post
    end
  
    def new
      # instantiate the form_for
      @store = Store.new
      authorize @store
    end
  
    def create
      @store = Store.new(store_params)
      @store.user = current_user
      if @store.save
        redirect_to store_path(@store)
      else
        render :new
      end
      authorize @store
    end
  
    def store_owner
      authorize @store
    end
  
    def edit
    end
  
    def update
      @store.update(store_params)
      redirect_to store_path(@store)
      authorize @store
    end
  
    def destroy
      @store.destroy
      redirect_to stores_path
    end
  
    private
  
    def store_params
      params.require(:store).permit(:name, :address, :discount_breakpoints, :description, :photo)
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
