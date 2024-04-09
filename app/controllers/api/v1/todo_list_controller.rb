# frozen_string_literal: true

module Api::V1
  class TodoListController < ApplicationController
    skip_before_action :basic_auth, only: [:index], raise: false
    skip_before_action :require_login, only: [:index]
    before_action :set_todo_list_item, only: [:show, :update, :destroy]

    # GET : /api/v1/todo_list
    def index
      todo_list_items = TodoListItem.order(:id)
      render json: todo_list_items
    end

    # GET : /api/v1/todo_list/:todo_list_item_id
    def show
      render json: @todo_list_item
    end

    # POST : /api/v1/todo_list
    def create
      todo_list_items = TodoListItem.new(todo_list_item_params)
      if todo_list_items.save
        render json: todo_list_items
      else
        render json: todo_list_items.errors
      end
    end

    # POST : /api/v1/todo_list/:todo_list_item_id
    def update
      if @todo_list_item.update(todo_list_item_params)
        render json: @todo_list_item
      else
        render json: @todo_list_item.errors
      end
    end

    # DELETE : /api/v1/todo_list/:todo_list_item_id
    def destroy
      if @todo_list_item.destroy
        render json: @todo_list_item
      else
        render json: @todo_list_item.errors
      end
    end

    private

    def todo_list_item_params
      params.require(:todo_list_item).permit(:content, :status)
    end

    def set_todo_list_item
      @todo_list_item = TodoListItem.find(params[:todo_list_item_id])
    end
  end
end
