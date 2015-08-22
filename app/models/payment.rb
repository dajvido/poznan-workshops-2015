class Payment < ActiveRecord::Base
  TUITUION = 700.0
  belongs_to :student

  validates :student_id, presence: true, numericality: { only_integer: true }
  validates :amount, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { only_float: true }

end
