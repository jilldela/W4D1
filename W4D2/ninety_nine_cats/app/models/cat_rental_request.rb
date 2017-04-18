class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: { in: ["APPROVED", "DENIED", "PENDING"] }
  validate :does_not_overlap_approved_request

  belongs_to :cat


  def overlapping_requests
    if self.persisted?
      CatRentalRequest.where("cat_id = ? AND id != ? AND ? BETWEEN start_date AND end_date", self.cat_id, self.id, self.start_date)
    else
      CatRentalRequest.where("cat_id = ? AND ? BETWEEN start_date AND end_date", self.cat_id, self.start_date)
    end
  end

  def overlapping_approved_requests
    self.overlapping_requests.where("status = 'APPROVED'")
  end

  private

  def does_not_overlap_approved_request
    if self.overlapping_approved_requests.length > 0
      errors[:base] << "Request overlaps existing request."
    end
  end


end
