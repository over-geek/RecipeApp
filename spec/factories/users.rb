FactoryBot.define do
  factory :user do
    name { 'franck' }
    email { 'francksefu1998@gmail.com' }
    password { '12345678' }
  end

  factory :user1 do
    name { 'franck' }
    email { 'francksefu1d998@gmail.com' }
    password { '12345678d' }
  end
end
