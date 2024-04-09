FactoryBot.define do
  factory :operator do
    sequence(:username, 'username_001')
    password { 'testtest' }
    password_confirmation { 'testtest' }
    sequence(:email) { |n| "test_mail_#{n}@example.com" }
  end
end
