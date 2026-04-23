class Article < ApplicationRecord
  has_many :comments, dependent: :delete_all
  belongs_to :genre

  validates :title, :presence => true
  validates :body, :presence => true
end
