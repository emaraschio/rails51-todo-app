require 'rails_helper'
require 'spec_helper'

describe "Editing todo items" do
	let!(:todo_list){ TodoList.create(title: "Abcdef", description: "xyzyx") }
	let!(:todo_item){ todo_list.todo_items.create(content: "qwer") }

	it "is successful with valid content" do
		visit_todo_list(todo_list)
		
		within("#todo_item_#{todo_item.id}") do
			click_link "Edit"
		end
		fill_in "Content", with: "qwerty"
		click_button "Save"
		expect(page).to have_content("Todo item was successfully updated")
		todo_item.reload
		expect(todo_item.content).to eq("qwerty")

	end

	it "displays an error with no content" do
		visit_todo_list(todo_list)

		within("#todo_item_#{todo_item.id}") do
			click_link "Edit"
		end
		fill_in "Content", with: ""
		click_button "Save"
		expect(page).to_not have_content("Todo item was successfully updated")
		todo_item.reload
		expect(page).to have_content("Content can't be blank")
		expect(todo_item.content).to eq("qwer")
	end

	it "displays an error with content less than 4 characters long" do
		visit_todo_list(todo_list)

		within("#todo_item_#{todo_item.id}") do
			click_link "Edit"
		end
		fill_in "Content", with: "qwe"
		click_button "Save"
		expect(page).to_not have_content("Todo item was successfully updated")
		todo_item.reload
		expect(page).to have_content("Content is too short")
		expect(todo_item.content).to eq("qwer")
	end
end