require 'rails_helper'
require 'spec_helper'

describe "Deleting todo items" do
	let!(:todo_list){ TodoList.create(title: "Abcdef", description: "xyzyx") }
	let!(:todo_item){ todo_list.todo_items.create(content: "qwer") }

	it "is successful with valid content" do
		visit_todo_list(todo_list)
		
		expect(todo_list.todo_items.count).to eq(1)

		within("#todo_item_#{todo_item.id}") do
			click_link "Destroy"
		end
		
		expect(page).to have_content("Todo list item was successfully destroyed")
		expect(todo_list.todo_items.count).to eq(0)

	end
end