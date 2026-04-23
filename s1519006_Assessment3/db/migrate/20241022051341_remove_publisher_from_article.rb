class RemovePublisherFromArticle < ActiveRecord::Migration[7.2]
  def change
    remove_column :articles, :genre, :string
  end
end
