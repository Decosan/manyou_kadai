class Task < ApplicationRecord 
  validates :title, presence: true
  validates :content, presence: true
  paginates_per 7

  scope :title_search, -> (title) { where('title LIKE ?', "%#{title}%")}
  scope :status_search, -> (status) { where('status LIKE ?', "%#{status}%")}
  scope :limit_sort, -> { order(sort_expired: :DESC)}
  scope :nil_limit, -> { where.not(sort_expired: nil)}

  enum priority: { Low: 0, Mid: 1, High: 2}
end
