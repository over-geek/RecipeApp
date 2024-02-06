class RecipeFood < ApplicationRecord
  belongs_to :food
  belongs_to :recipe

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :food, uniqueness: { scope: :recipe_id }
end
