class User < ApplicationRecord
  has_many :foods
  accepts_nested_attributes_for :foods
  has_many :recipes, dependent: :destroy
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
