# app/models/appointment.rb
class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :daddy_service

  validates :status, inclusion: { in: [true, false] }
  after_initialize :set_default_status, if: :new_record?

  attr_accessor :time  # Ajoute l'attribut virtuel time

  before_validation :combine_date_and_time


  private

  def set_default_status
    self.status ||= false
  end

  def combine_date_and_time
    return unless date.present? && time.present?

    hours, minutes = time.split(':').map(&:to_i)
    self.date = date.change(hour: hours, min: minutes)
  end
end
