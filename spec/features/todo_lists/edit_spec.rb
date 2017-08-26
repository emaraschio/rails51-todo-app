require 'rails_helper'
require 'spec_helper'

describe "Editing todo lists" do
	let!(:todo_list){ TodoList.create(title: "Abcdef", description: "xyzyx") }
	def update_todo_list(options={})
		options[:title] ||= "My title."
		options[:description] ||= "My todo list description."

		todo_list = options[:todo_list]

		visit "todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "Edit"
		end
		
		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]

		click_button "Update Todo list"
	end

	it "updates a todo list successfully with correct data" do
		update_todo_list todo_list: todo_list, title: "New title", description: "New description"
		todo_list.reload

		expect(page).to have_content("Todo list was successfully updated")
		expect(todo_list.title).to eq("New title")
		expect(todo_list.description).to eq("New description")
	end

	it "displays an error when the updated todo list has no title" do
		update_todo_list todo_list: todo_list, title: ""
		title = todo_list.title
		todo_list.reload
		expect(page).to have_content("error")
		expect(todo_list.title).to eq(title)
	end

	it "displays an error when the updated todo list has no description" do
		update_todo_list todo_list: todo_list, description: ""
		description = todo_list.description
		todo_list.reload
		expect(page).to have_content("error")
		expect(todo_list.description).to eq(description)
	end

	it "displays an error when the updated todo list title is less than 4 characters" do
		update_todo_list todo_list: todo_list, title: "xyz"
		title = todo_list.title
		todo_list.reload
		expect(page).to have_content("error")
		expect(todo_list.title).to eq(title)
	end

	it "displays an error when the updated todo list description is less than 4 characters" do
		update_todo_list todo_list: todo_list, description: "xyz"
		description = todo_list.description
		todo_list.reload
		expect(page).to have_content("error")
		expect(todo_list.description).to eq(description)
	end
end