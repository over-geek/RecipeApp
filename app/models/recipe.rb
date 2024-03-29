class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods, dependent: :destroy

  def calculate_total_amount
    total_amount = 0
    recipe_foods.each do |recipe_food|
      total_amount += recipe_food.food.price * recipe_food.quantity
    end
    total_amount
  end

  # scope :public_recipes, -> { where(public: true) }

  # def public?
  #   is_public
  # end

  validates :name, presence: true, length: { in: 0..250 }
  validates :preparation_time, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :cooking_time, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
