require 'rails_helper'
require 'spec_helper'

describe "Creating todo lists" do
  def create_todo_list(options={})
    options[:title] ||= "My title."
    options[:description] ||= "My todo list description."

    visit "todo_lists"
    click_link "New Todo List"

    expect(page).to have_content("New Todo List")

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]

    click_button "Create Todo list"
  end
  it "redirects to the todo list index page on success" do
    create_todo_list

    expect(page).to have_content("My title.")
    expect(page).to have_content("My todo list description.")
    expect(TodoList.count).to eq(1)
  end

  it "displays an error when the todo list has no title" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: ""

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
  end

  it "displays an error when the todo list has no description" do
    expect(TodoList.count).to eq(0)

    create_todo_list description: ""

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
  end

  it "displays an error when the todo list title is less than 4 characters" do
    expect(TodoList.count).to eq(0)

    create_todo_list title:"thr"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
  end

  it "displays an error when the todo list description is less than 4 characters" do
    expect(TodoList.count).to eq(0)

    create_todo_list description: "des"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
  end
end