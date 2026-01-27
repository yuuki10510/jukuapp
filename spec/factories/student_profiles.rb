FactoryBot.define do
  factory :student_profile do
    school_name { "〇〇中学校" }
    grade { "中2" }
    active { true }
    association :user, factory: [:user, :student]
  end
end
