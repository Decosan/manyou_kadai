class Task < ApplicationRecord 
  validates :title, presence: true
  validates :content, presence: true

  scope :title_search, -> (title) { where('title LIKE ?', "%#{title}%")}
  scope :status_search, -> (status) { where('status LIKE ?', "%#{status}%")}
  
end
