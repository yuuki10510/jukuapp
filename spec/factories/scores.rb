FactoryBot.define do
  factory :score do
    subject { 0 } 
    test_type { 0 }
    term { 0 }
    value { 80 }
    association :student, factory: [:user, :student]
  end
end
