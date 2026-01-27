FactoryBot.define do
  factory :user do
    name { "山田太郎" }
    email { "test#{rand(1000)}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    role { "parent" }
    active { true }

    trait :student do
      role { "student" }
    end

    trait :admin do
      role { "admin" }
    end
  end
end
