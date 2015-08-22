class Student < ActiveRecord::Base
  has_many :participations, dependent: :destroy
  has_many :subject_items, through: :participations
  has_many :subject_item_notes, dependent: :destroy
  has_many :payments, dependent: :destroy

  accepts_nested_attributes_for :subject_items

  validates :first_name, :last_name, :start_date, presence: true

  def full_payment
    payments.map(&:amount).inject(0) { |sum, p| sum + p }
  end

  def study_period
    unless end_date.nil?
      (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month)
    else
      (DateTime.now.to_date.year * 12 + DateTime.now.to_date.month) - (start_date.year * 12 + start_date.month)
    end
  end

  def paid_months
    full_payment / Payment::TUITUION
  end

  def in_debt?
    not(paid_months >= study_period)
  end

  def debt
    (study_period - paid_months) * Payment::TUITUION
  end

end
