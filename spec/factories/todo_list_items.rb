FactoryBot.define do
  factory :todo_list_item do
    sequence(:content, 'やることその1')
    state { 0 }
  end
end
