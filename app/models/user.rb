class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save :downcase_email
  before_create :create_activation_digest
  has_many :feedbacks, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :name, presence: true, length: {maximum: Settings.length_name}
  VALID_EMAIL_REGEX = Settings.email_regex
  validates :email, presence: true, length: {maximum: Settings.length_email}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :address, length: {maximum: Settings.length_address}
  validates :password, presence: true, length: {minimum: Settings.pw_min}, allow_nil: true
  mount_uploader :avatar, PictureUploader
  has_secure_password
  scope :selected, -> {select :id, :name, :email, :avatar}
  scope :ordered, -> {order created_at: :DESC}
  scope :admin_search_user, -> (search){
    where("name LIKE ?", "%#{search}%")
  }

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def activate
    update_attribute :activated, true
    update_attribute :activated_at, Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
