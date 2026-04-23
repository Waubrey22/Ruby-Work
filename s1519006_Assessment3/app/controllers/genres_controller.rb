class GenresController < ApplicationController
  protect_from_forgery with: :null_session

  # Logic for updating categories
  def update
    @genres = Genre.all
    @genre = Genre.find(params[:id])

    if @genre.update(genre_params)
      redirect_to "/admin"
    else
      render :action => 'articles/editC'
    end
  end

  # Logic for creating categories
  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      redirect_to "/admin"
    else
      render :action => 'articles/newC'
    end
  end

  # Logic for deleting categories
  def destroy
    @genre = Genre.find(params[:id])
    @articles_filtered = Array.new
    @articles_filtered = Article.find(@genre.id)

    if @genre.destroy
      redirect_to "/admin"
    end
  end

  # Category parameters for updating
  def genre_params
    params.inspect
    params.require(:genre).permit(:id, :title, :created_at, :updated_at)
  end
end
