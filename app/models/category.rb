class Category < ApplicationRecord
  has_many :daddy_services
  has_many :users, through: :daddy_services
end
