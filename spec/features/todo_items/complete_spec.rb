require 'rails_helper'
require 'spec_helper'

describe "Completing todo items" do
	let!(:todo_list){ TodoList.create(title: "Abcdef", description: "xyzyx") }
	let!(:todo_item){ todo_list.todo_items.create(content: "qwer") }

	it "is successful with marking a single item complete" do
		expect(todo_item.completed_at).to be_nil
		visit_todo_list(todo_list)
		within(dom_id_for(todo_item)) do
			click_link "Mark complete"
		end
		todo_item.reload
		expect(todo_item.completed_at).to_not be_nil
	end

	context "with completed items" do
		let!(:completed_todo_item){ todo_list.todo_items.create(content:"zxcvbnm", completed_at: 5.minutes.ago) }

		it "shows completed items as complete" do
			visit_todo_list(todo_list)
			within dom_id_for(completed_todo_item) do
				expect(page).to have_content(completed_todo_item.completed_at)
			end
		end

		it "does not give the option to mark complete when completed" do
			visit_todo_list(todo_list)
			within dom_id_for(completed_todo_item) do
				expect(page).to_not have_content("Mark complete")
			end
		end
	end
end