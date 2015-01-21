class Task
  # @@all_tasks = []
  attr_reader(:description, :list_id, :due_date)

  define_method(:initialize) do |attribute|
    @description = attribute.fetch(:description)
    @list_id = attribute.fetch(:list_id)
    @due_date = attribute.fetch(:due_date)
  end

  define_singleton_method(:all) do
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch("description")
      list_id = task.fetch("list_id").to_i()
      due_date = task.fetch("due_date")
      tasks.push(Task.new({:description => description, :list_id => list_id, :due_date => due_date}))
    end
    tasks
  end

  define_method(:save) do
    DB.exec("INSERT INTO tasks (description, list_id, due_date) VALUES ('#{@description}', #{@list_id}, '#{@due_date}')")
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM tasks *;")
  end

  define_method(:==) do |another_task|
    self.description().==(another_task.description()).&(self.list_id().==(another_task.list_id()))
  end





end
