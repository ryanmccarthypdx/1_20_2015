require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/list')
require('./lib/task')
require('pg')

DB = PG.connect({:dbname => "to_do"})

get('/') do
  @title = "My To-do Lists"
  @list_of_lists = List.all()
  erb(:lists)
end

post('/posted') do
  @title = "My To-do Lists"
  @name = params.fetch("name")
  new_list = List.new({ :name => @name, :id => nil })
  new_list.save()
  @list_of_lists = List.all()
  erb(:lists)
end

get('/tasks/:id') do
  @task_list = List.sel(params.fetch('id'))
  @title = "<%= @name %>"
  erb(:tasks)
end



post('/posted_task/:id') do
  @title = "My To-do Lists"
  @description = params.fetch("description")


  erb(:tasks)
end
