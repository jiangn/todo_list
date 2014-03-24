class TodosController < ApplicationController
  before_filter :get_user
  before_filter :get_todos

  def show
  end

  def index
  end

  def create
    response = post_request("/users/#{@user["id"]}/todos", {:todo => params})
    @todo = parse_json_response(response)
    @todo['order'] = @todos.length
    @todos << @todo
    session[:todos] = @todos
    render :create_or_update
  end

  def mark_complete
   response = put_request("/users/#{@user["id"]}/todos/#{params['todo_id']}", {:todo => {:is_complete => true}})
   todo_updated = parse_json_response(response)
    todo = @todos.detect {|todo| todo['id'] == params['todo_id'].to_i}
    todo['is_complete'] = true
    session[:todos] = @todos
    render :create_or_update
  end

  def change_order
    params['todo_order'].each_with_index do |todo_id, order|
      todo = @todos.detect {|todo| todo['id'] == todo_id.to_i}
      todo['order'] = order.to_i
    end
    @todos.sort_by!{|todo| todo['order']}
    session[:todos] = @todos
    render :create_or_update
  end

  private

  def get_todos
    @todos = session["todos"]
    if @todos.nil?
      response = get_request("/users/#{@user["id"]}/todos")
      @todos = parse_json_response(response)
      @todos.sort_by!{|todo| todo['id']}
      @todos.each_with_index do |todo, i|
        todo['order'] = i
      end
      session[:todos] = @todos
    end
  end
end
