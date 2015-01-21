# require('task')
require('pry')



class List
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_lists = DB.exec("SELECT * FROM lists;")
    lists = []
    returned_lists.each() do |list|
      name = list.fetch("name")
      id = list.fetch("id").to_i()
      lists.push(List.new({:name => name, :id => id}))
    end
    lists
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:tasks) do
    returned_tasks = DB.exec("SELECT * FROM tasks WHERE list_id = #{self.id()} ORDER BY due_date;")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch("description")
      list_id = task.fetch("list_id").to_i()
      due_date = task.fetch("due_date")
      recreated_task = (Task.new({:description => description, :list_id => list_id, :due_date => due_date}))
      tasks.push(recreated_task)
    end
    tasks
  end

  define_singleton_method(:sel) do |id|
    selection = []
    select_result = DB.exec("SELECT * FROM lists WHERE id = #{id};")
    select_result.each() do |result| #even though i know it's only a single possible return
      name = result.fetch("name")
      list_id = result.fetch("id")
      selection.push(List.new({ :name => name, :id => list_id}))
    end
    selection[0]
  end


  define_method(:==) do |another_list|
    self.name().==(another_list.name()).&(self.id().==(another_list.id()))
  end
end
