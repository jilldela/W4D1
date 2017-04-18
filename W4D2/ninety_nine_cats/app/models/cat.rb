class Cat < ActiveRecord::Base
  COLORS = ["Brown", "Orange", "Black", "White", "Grey"]
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: COLORS }
  validates :sex, inclusion: { in: ["M", "F"] }

  has_many :cat_rental_requests,
    dependent: :destroy

  def rental_start_end_dates
    self.cat_rental_requests
      .select(:start_date, :end_date)
      .order(:start_date)
  end
end
