class UsersController < ApplicationController
  def index
    clear_session
  end

  def create
    @user = User.new(params)
    response = post_request('/users/sign_in', @user.serializable_hash.merge(:password => params[:password]))
    ret = parse_json_response(response)
    if response.code == '200'
      session[:user] = User.new(ret)
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
