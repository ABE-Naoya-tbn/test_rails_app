FactoryBot.define do
  factory :todo_list_item do
    sequence(:content, 'やることその1')
    status { true }
  end
end
