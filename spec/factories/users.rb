FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Hermione Granger #{n}" }
    sequence(:email) { |e| "harry#{e}@potter.com" }
    password "HarryPotter"

  end
end
