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
  @id = params.fetch('id')
  @list = List.sel(@id)
  @all_tasks_in_list = @list.tasks()
  @name = @list.name()
  @title = "<%= @name %>"
  erb(:tasks)
end

post('/posted_task/:id') do
  @description = params.fetch("description")
  @due_date = params.fetch("due_date")
  @id = params.fetch('id')
  new_task = Task.new({ :description => @description, :list_id => @id, :due_date => @due_date})
  new_task.save()
  @list = List.sel(@id)
  @all_tasks_in_list = @list.tasks()
  @name = @list.name()
  @title = "<%= @name %>"
  erb(:tasks)
end
