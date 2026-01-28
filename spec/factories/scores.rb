FactoryBot.define do
  factory :score do
    subject { :math }
    test_type { :regular }
    term { :first_mid }
    score { 80 }
    association :student, factory: [:user, :student]
  end
end
