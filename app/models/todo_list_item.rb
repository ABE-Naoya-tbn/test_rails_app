# frozen_string_literal: true

class TodoListItem < ApplicationRecord
  validates :content, presence: true, length: { minimum: 1, maximum: 255 }
end
