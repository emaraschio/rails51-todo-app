class TodoItemsController < ApplicationController
	before_action :find_todo_list
	before_action :find_todo_item, only: [:show, :edit, :update, :destroy, :complete]
	before_action :url_options
	
	def index
		
	end

	def new
		@todo_item = @todo_list.todo_items.new
	end

	def create
		@todo_item = @todo_list.todo_items.new(todo_item_params)
		respond_to do |format|
			if @todo_item.save
				format.html { redirect_to todo_list_todo_items_path(@todo_list), notice: 'Todo item was successfully created.' }
				format.json { render :show, status: :created, location: todo_list_todo_items_path(@todo_list) }
			else
				format.html { render :new }
				format.json { render json: @todo_list.errors, status: :unprocessable_entity }
			end
		end
	end

	def show
	end

	def edit

	end

	def update
		respond_to do |format|
			if @todo_item.update(todo_item_params)
				format.html { redirect_to todo_list_todo_items_path(@todo_list), notice: 'Todo item was successfully updated.' }
				format.json { render :show, status: :ok, location: todo_list_todo_items_path(@todo_list) }
			else
				format.html { render :edit }
				format.json { render json: @todo_list.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@todo_item.destroy
		respond_to do |format|
			format.html { redirect_to todo_list_todo_items_url, notice: 'Todo list item was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	def url_options
		{ todo_list_id: params[:todo_list_id] }.merge(super)
	end

	def complete
		@todo_item.update_attribute(:completed_at, Time.now)
		redirect_to todo_list_todo_items_path, notice: "Todo item marked as complete!"
	end

	private

	def find_todo_list
		@todo_list = TodoList.find(params[:todo_list_id])
	end

	def todo_item_params
		params.require(:todo_item).permit(:content)
	end

	def find_todo_item
		@todo_item = @todo_list.todo_items.find(params[:id])
	end
end
