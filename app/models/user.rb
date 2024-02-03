class User < ApplicationRecord
  include HasBuilder

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  validates :name, presence: true
  validates :email, presence: true

  has_many :characters

  def current_character
    return nil unless current_character_id

    Character.find(current_character_id)
  end
end
