FactoryGirl.define do
  factory :payment do
    association :student, factory: :student
    amount { Faker::Number.decimal(2) }
  end

end
