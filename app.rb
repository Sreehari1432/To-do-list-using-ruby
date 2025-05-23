require 'sinatra'
require 'sinatra/reloader' if development?

set :tasks, []

get '/' do
  erb :index
end

post '/add' do
  task = params[:task]
  settings.tasks << { description: task, done: false } unless task.empty?
  redirect '/'
end

post '/complete/:id' do
  id = params[:id].to_i
  settings.tasks[id][:done] = true if settings.tasks[id]
  redirect '/'
end

post '/delete/:id' do
  id = params[:id].to_i
  settings.tasks.delete_at(id) if settings.tasks[id]
  redirect '/'
end
