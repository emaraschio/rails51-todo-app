require 'rails_helper'
require 'spec_helper'

describe "Adding todo items" do
	let!(:todo_list){ TodoList.create(title: "Abcdef", description: "xyzyx") }

	it "is successful with valid content" do
		visit_todo_list(todo_list)
		click_link "New Todo Item"
		fill_in "Content", with: "item1"
		click_button "Save"
		expect(page).to have_content("Todo item was successfully created")
		within("ul.todo_items") do
			expect(page).to have_content("item1")
		end
	end

	it "displays an error with no content" do
		visit_todo_list(todo_list)
		click_link "New Todo Item"
		fill_in "Content", with: ""
		click_button "Save"
		# expect(page).to have_content("There was a problem adding this todo list item")
		expect(page).to have_content("Content can't be blank")
	end

	it "displays an error with content less than 4 characters long" do
		visit_todo_list(todo_list)
		click_link "New Todo Item"
		fill_in "Content", with: "abc"
		click_button "Save"
		# expect(page).to have_content("There was a problem adding this todo list item")
		expect(page).to have_content("Content is too short")
	end
end