class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    articles = Article.all.includes(:user).order(created_at: :desc)
    render json: articles, each_serializer: ArticleListSerializer
  end

  def show 
    session[:page_views] ||= 0
    if session[:page_views]  < 3
    increment_views
    article = Article.find(params[:id])
    render json: article
    else
    increment_views
      access_denied
    end
    
    
    
   
  end

  private
  def increment_views
session[:page_views] += 1
  end

  def record_not_found
    render json: { error: "Article not found" }, status: :not_found
  end

  def access_denied
    render json: {error: 'Maximum pageview limit reached'}, status: :unauthorized
  end

end
