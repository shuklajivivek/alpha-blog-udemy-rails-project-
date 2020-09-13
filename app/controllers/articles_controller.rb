class ArticlesController < ApplicationController
before_action :set_article, only: [:show, :edit, :update, :destroy]
before_action :require_user, except: [:show, :index]
before_action :require_same_user, only: [:edit, :update, :destroy]

def show   
end
def index
  @articles = Article.paginate(page: params[:page], per_page: 2)
end
def new
  @article = Article.new
end

def edit
  
end

def create
    
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was successfully created"
      redirect_to article_path(@article)
    #above line can also be written as redirect_to @article (shorthand syntax)
    else
    render 'new'
    end
end

def update
  if @article.update(article_params)
    flash[:notice] = "Article was successfully updated"
    redirect_to @article
  else
    render 'edit'
  end
end

def destroy
  @article.destroy
  redirect_to @article
end
  
  private

  def set_article
    @article = Article.find(params[:id])
  end
  
  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    byebug
    if current_user != @article.user
      flash[:alert] = "you can edit or delete only your own article"
      redirect_to @article
    end
  end

end