class User < ApplicationRecord
  has_many :user_viewing_parties
  has_many :viewing_parties, through: :user_viewing_parties

  validates_presence_of :name 
  validates_presence_of :email 
  validates_uniqueness_of :email 
  # validates :password, presence: true, confirmation: true, on: :create
  # validates :password_confirmation, presence: true , on: :create
  # validates :password, presence: true
  has_secure_password

  def users_parties
    viewing_parties
      .select("viewing_parties.*, user_viewing_parties.status")
      .includes(:user_viewing_parties)
  end
end
