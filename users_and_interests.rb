require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require 'yaml'

USER_INFO = YAML.load_file('data/users.yaml')

before do
  @users = USER_INFO.keys
end

helpers do
  def count_interests
    @users.map do |user|
      USER_INFO[user][:interests].count
    end.sum
  end
end


get "/" do
  @title = "Home"
  erb :home
end

get "/:user" do
  @user = params[:user]
  @user_info = USER_INFO[@user.to_sym]

  @title = @user.capitalize

  redirect "/" if @user_info.nil?

  erb :user
end

