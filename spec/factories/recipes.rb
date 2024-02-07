FactoryBot.define do
  factory :recipe do
    association :user, factory: :user
    name { 'franck' }
    preparation_time { 1 }
    cooking_time { 1 }
    description { 'Bon ceci est une petite description' }
  end
end
