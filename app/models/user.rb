class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :daddy_services
  has_many :categories, through: :daddy_services
  has_many :appointments, dependent: :destroy
  has_many :daddy_services, through: :appointments
  has_many :reviews, dependent: :destroy

end
