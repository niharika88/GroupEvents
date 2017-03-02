class Groupevent < ApplicationRecord

  enum status: [ :draft, :published ]
  
  validates_presence_of :name, :description, :location, :start_date, :end_date, :duration, unless: "draft?", on: :update
  validates :name, :location, length: { maximum: 255 }
  validates :description,     length: { maximum: 500 }
  validate :check_finish_start_mismatch
  
  after_validation :get_interval
  after_validation :get_start_date
  after_validation :get_end_date

  def publish!
    self.update status: :published 
  end

  def destroy
    run_callbacks :destroy do
      update! deleted_at: DateTime.now
    end
  end
  
  private

  def check_finish_start_mismatch
    return if !start_date.present? || !end_date.present?
    errors.add(:start_date, I18n.t('groupevents.errors.finish_start_mismatch')) if end_date < start_date
  end

  def get_interval
    return if !start_date.present? || !end_date.present?
    self.duration = (end_date - start_date) + 1
  end
  
  def get_end_date
    return if !start_date.present? || !self.duration.present?
    self.end_date = start_date + (duration.days - 1)
  end

  def get_start_date
  	return if !self.duration.present? || !end_date.present?
  	self.start_date = end_date -  duration.days 
  end

end
