class UsersController < ApplicationController

before_action :set_user, only: [:show, :edit, :update]
before_action :require_user, only: [:edit, :update]
before_action :require_same_user, only: [:edit, :update]
def new
    @user = User.new
end

def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 2)
end

def edit
end

def index
    @users = User.paginate(page: params[:page], per_page: 2)
end

def update
    if @user.update(user_params)
    flash[:notice] = "Profile successfully updated"
    redirect_to @user #@user is short hand for user_path(userid)
  else
    render 'edit'
  end
end

def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Hi #{@user.username} You have sucessfully signed up for alpha-blog"
      redirect_to articles_path
    else
        render 'new'
    end
end

 private
 def user_params
    params.require(:user).permit(:username, :email, :password)
 end
 def set_user
    @user = User.find(params[:id])
 end

 def require_same_user
   if current_user != @user
    flash[:alert] = "you can edit only your profile"
 end
end

end