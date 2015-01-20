class Task
  # @@all_tasks = []
  attr_reader(:description)

  define_method(:initialize) do |attribute|
    @description = attribute.fetch(:description)
  end

  define_singleton_method(:all) do
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch("description")
      tasks.push(Task.new({:description => description}))
    end
    tasks
  end

  define_method(:save) do
    DB.exec("INSERT INTO tasks (description) VALUES ('#{@description}')")
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM tasks *;")
  end

  define_method(:==) do |another_task|
    self.description().==(another_task.description())
  end





end
