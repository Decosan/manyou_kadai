class User < ApplicationRecord
  has_secure_password
  before_validation {email.downcase!}
  has_many :tasks , dependent: :destroy
  before_destroy :least_one
  
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }


  private

  def least_one
    if self.admin? && User.all.where(admin: "true").count == 1
      # return false　ではなく throw :abort
      throw :abort
    end
  end
end
