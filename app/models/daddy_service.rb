class DaddyService < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :appointments, dependent: :destroy
  has_many :users, through: :appointments
  has_one_attached :photo
  has_many :reviews, dependent: :destroy

  after_create :update_user_pro_status
  after_destroy :check_user_pro_status

  def average_rating
    reviews.average(:rating).to_f.round(1)
  end

  private

  def update_user_pro_status
    user.update(role: true) unless user.role
  end

  def check_user_pro_status
    # Si c'était le dernier service, passe pro à false
    if user.daddy_services.count == 0
      user.update(role: false)
    end
  end


  def self.search_by_title_and_category(query)
    where("title ILIKE ? OR categories.name ILIKE ?", "%#{query}%", "%#{query}%")
    .joins(:category)
  end

  def available_slots(date = Date.today)
    # Crée un tableau de tous les créneaux possibles pour la journée
    all_slots = []
    current = date.beginning_of_day + 9.hours # Commence à 9h
    end_time = date.beginning_of_day + 18.hours # Termine à 18h

    while current < end_time
      all_slots << current
      current += 30.minutes
    end

    # Retire les créneaux déjà réservés
    taken_slots = appointments.where(date: date.beginning_of_day..date.end_of_day)
                            .pluck(:date)

    all_slots - taken_slots
  end
end
