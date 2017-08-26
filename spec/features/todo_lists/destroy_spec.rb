require 'rails_helper'
require 'spec_helper'

describe "Deleting todo lists" do
	let!(:todo_list){ TodoList.create(title: "Abcdef", description: "xyzyx") }

	it "deletes a todo list successfully" do
		visit "todo_lists"
		
		within "#todo_list_#{todo_list.id}" do
			click_link "Destroy"
		end

		expect(page).to_not have_content(todo_list.title)
		expect(page).to_not have_content(todo_list.description)
		expect(TodoList.count).to eq(0)
	end
end