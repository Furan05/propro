class DaddyService < ApplicationRecord
  belongs_to :user
  belongs_to :category

  def self.search_by_title_and_category(query)
    where("title ILIKE ? OR categories.name ILIKE ?", "%#{query}%", "%#{query}%")
    .joins(:category)
  end
end
