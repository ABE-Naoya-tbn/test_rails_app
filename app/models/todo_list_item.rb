# frozen_string_literal: true

class TodoListItem < ApplicationRecord
  enum :state, {
    outstanding: 0,    # 未処理
    processing: 1,     # 処理中
    processed: 2,      # 処理済み
    completed: 3       # 完了
  }

  validates :content, presence: true, length: { minimum: 1, maximum: 255 }
end
