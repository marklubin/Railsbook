class Product < ActiveRecord::Base
  has_many :line_items
  validates :title, :description, :image_url, presence: true
  validates :title, length: {minimum: 4}
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
      with: %r{\.(gif|jpg|png)\Z}i,
      message: 'must be a URL for a GIF, JPG or PNG'
  }

  before_destroy :ensure_not_referenced

  def self.latest
    Product.order(:updated_at).last
  end

  private
  def ensure_not_referenced
     if line_items.empty?
       return true
     else
       errors.add(:base, 'Line items present')
       return false
     end
  end
end
