class AddGenreToArticle < ActiveRecord::Migration[7.2]
  def change
    add_reference :articles, :genre, null: false, foreign_key: true
  end
end
