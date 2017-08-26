require 'rails_helper'
require 'spec_helper'

describe "Viewing todo items" do
	let!(:todo_list){ TodoList.create(title: "Abcdef", description: "xyzyx") }

	it "displays the title of todo list" do
		visit_todo_list(todo_list)
		within("h1.title") do
			expect(page).to have_content(todo_list.title)
		end
	end

	it "displays no items when todo list is empty" do
		visit_todo_list(todo_list)
		expect(page.all("ul.todo_items li").size).to eq(0)
	end

	it "displays item content when a todo list has items" do
		todo_list.todo_items.create(content: "item1")
		todo_list.todo_items.create(content: "item2")
		todo_list.todo_items.create(content: "item3")
		
		visit_todo_list(todo_list)
		expect(page.all("ul.todo_items li").size).to eq(3)
		within("ul.todo_items") do
			expect(page).to have_content("item1")
			expect(page).to have_content("item2")
			expect(page).to have_content("item3")
		end
	end
end