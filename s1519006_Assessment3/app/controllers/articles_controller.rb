class ArticlesController < ApplicationController
  protect_from_forgery with: :null_session
  # Index, uses .order to create an order of articles based on the time each article was last updated
  def index
    @articles = Article.all
    @articlesSorted = Article.order(updated_at: :desc)
  end

  # Displays all information related to the article, uses .find to get the relevant genre title for the article
  def show
    @article = Article.find(params[:id])
    @genre = Genre.find(@article.genre_id)
  end

  # Pulls all information related to all articles and genres for display
  def news
    @articles = Article.all
    @genres = Genre.all
  end

  # Searches in all article titles and bodies to search for relevant content
  def search
    @articles = Article.all

    if params[:term].to_s.length >0
      @foundArticles = Array.new
      # Creates an array to place all articles where it finds relevant content in
      @articles.each do |article|
        if article.body.downcase.include? params[:term].to_s.downcase
          @foundArticles.push(article)
        elsif article.title.downcase.include? params[:term].to_s.downcase
          @foundArticles.push(article)
        end
      end
      puts @foundArticles
    end
  end

  # Admin login screen information
  def adminlog
    @users = User.all
  end

  # Admin login logic, tests entered details against information in the User table, if both match logs user in
  def login
    @users = User.all
    @users.each do |user|
      if params[:uname].to_s == user.uname && params[:pword].to_s == user.pword
        redirect_to '/admin/'
      end
    end
  end

  # Admin main screen information
  def admin
    @articles = Article.all
    @genres = Genre.all
  end

  def hide
    @articles = Article.all
    @genres = Genre.all
  end

  # Article parameters for updating
  def article_params
    params.inspect
    params.require(:article).permit(:id, :title, :body, :created_at, :updated_at, :genre_id, :publisher)
  end

  # Information needed for editing article
  def editA
    @article = Article.find(params[:id])
    @genres = Genre.all
    @genre = Genre.find(@article.genre_id)
  end

  # Information needed for editing category
  def editC
    @genre = Genre.find(params[:id])
  end

  # Logic for updating articles
  def update
    @article = Article.find(params[:id])
    @genres = Genre.all
    @genre = Genre.find(@article.genre_id)

    if @article.update(article_params)
      redirect_to "/admin"
    else
      render :action => 'editA'
    end
  end

  # Information needed for creating articles
  def newA
    @article = Article.new
    @genres = Genre.all
  end

  # Information needed for creating categories
  def newC
    @genre = Genre.new
  end

  # Logic for creating articles
  def create
    @article = Article.new(article_params)
    @genres = Genre.all

    if @article.save
      redirect_to "/admin"
    else
      render :action => 'newA'
    end
  end

  # Information needed to delete articles
  def removeA
    @article = Article.find(params[:id])
    @genres = Genre.all
    @genre = Genre.find(@article.genre_id)
  end

  # Information needed to delete categories
  def removeC
    @genre = Genre.find(params[:id])
    @articles_filtered = Array.new
    @articles_filtered = Article.find(@genre.id)
  end

  # Logic needed to delete articles
  def destroy
    @article = Article.find(params[:id])
    @genre = Genre.find(@article.genre_id)

    if @article.destroy
      redirect_to "/admin"
    end
  end
end
