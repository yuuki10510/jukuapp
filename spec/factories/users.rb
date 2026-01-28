FactoryBot.define do
  factory :user do
    name { "山田太郎" }
    email { "test_#{SecureRandom.hex(4)}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    active { true }
    role { "parent" }

    trait :admin do
      role { "admin" }
    end

    trait :student do
      role { "student" }

      after(:create) do |user|
        create(
          :student_profile,
          user: user,
          grade: "中1",
          active: true
        )
      end
    end
  end
end
