class UsersController < ApplicationController
  def index
    clear_session
  end

  def create
    response = post_request('/users/sign_in', {:email => params[:email], :password => params[:password]})
    ret = parse_json_response(response)
    if response.code == '200'
      session[:user] = ret
      render :json => {:url => user_todos_path(ret["id"])}
    else
      render :json => ret, :status => response.code
    end
  end

  def destroy
    response = delete_request('/users/sign_out')
    clear_session
    render :json => {:url => users_path}
  end

  def clear_session
    session.delete(:user)
    session.delete(:todos)
  end
end
