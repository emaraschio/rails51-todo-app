class TodoList < ApplicationRecord
  validates :title, presence: true, length: { minimum: 4 }
  validates :description, presence: true, length: { minimum: 4 }
  has_many :todo_items, dependent: :destroy

  def has_complete_items?
    todo_items.complete.size > 0
  end

  def has_incomplete_items?
    todo_items.incomplete.size > 0
  end
end
