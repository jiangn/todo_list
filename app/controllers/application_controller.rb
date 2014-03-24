require 'net/http'
require 'json'

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  HOST = '54.204.31.244'
  PORT = '3000'
  SERVER = Net::HTTP.new(HOST, PORT)

  def post_request path, body={}
    request = Net::HTTP::Post.new(path, initheader = {'Content-Type' =>'application/json'})
    request.body = default_params.merge(body).to_json
    response = SERVER.start {|http| http.request(request) }
    response
  end

  def get_request path, body={}
    request = Net::HTTP::Get.new(path, initheader = {'Content-Type' =>'application/json'})
    request.body = default_params.merge(body).to_json
    response = SERVER.start {|http| http.request(request) }
    response
  end

  def put_request path, body={}
    request = Net::HTTP::Put.new(path, initheader = {'Content-Type' =>'application/json'})
    request.body = default_params.merge(body).to_json
    response = SERVER.start {|http| http.request(request) }
    response
  end

  def delete_request path, body={}
    request = Net::HTTP::Delete.new(path, initheader = {'Content-Type' =>'application/json'})
    request.body = default_params.merge(body).to_json
    response = SERVER.start {|http| http.request(request) }
    response
  end

  def parse_json_response response
    JSON.parse(response.body)
  end

  def get_user
    @user = session["user"]
    raise ActiveResource::UnauthorizedAccess.new("There is no longer an active session for this user!") if @user.nil?
  end

  def default_params
    session["user"].nil? ? {} : {:api_token => session["user"]["api_token"]}
  end
end
