class AddPublisherToArticle < ActiveRecord::Migration[7.2]
  def change
    add_column :articles, :publisher, :string
  end
end
