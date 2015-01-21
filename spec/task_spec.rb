require('spec_helper')

describe(Task) do
  describe("#description") do
    it("lets you give it a description") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1, :due_date => 2014-01-01})
      expect(test_task.description()).to(eq("learn SQL"))
    end
  end

  describe(".all") do
    it("is empty at first") do
    expect(Task.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a task to the array of saved tasks") do
    test_task = Task.new({:description => "learn SQL", :list_id => 1, :due_date => "2014-01-01"})
    test_task.save()
    expect(Task.all()).to(eq([test_task]))
    end
  end

  describe(".clear") do
    it("empties all the saved tasks") do
      Task.new({:description => "learn SQL", :list_id => 1, :due_date => "2014-01-01"}).save()
      Task.clear()
      expect(Task.all()).to(eq([]))
    end
  end

  describe("#list_id") do
    it("lets you read the list ID out") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1, :due_date => "2014-01-01"})
      expect(test_task.list_id()).to(eq(1))
    end
  end

  describe("#due_date") do
    it("lets you read list due date") do
      test_due_date = Task.new({:description => "learn SQL", :list_id => 1, :due_date => "2014-01-01"})
      expect(test_due_date.due_date()).to(eq("2014-01-01"))
    end
  end

  describe("#==") do
    it("is the same task if it has the same description") do
      task1 = Task.new({:description => "learn SQL", :list_id => 1, :due_date => "2014-01-01" })
      task2 = Task.new({:description => "learn SQL", :list_id => 1, :due_date => "2014-01-01" })
      expect(task1).to(eq(task2))
    end
  end

  # before() do
  #   Task.clear()
  # end
  #   ABSOLUTE GENIUS IF YOU ASK ME!

end
