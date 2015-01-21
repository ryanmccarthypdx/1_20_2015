require('spec_helper.rb')

describe(List) do
  describe(".all") do
    it("starts off with no lists") do
      expect(List.all()).to(eq([]))
    end
  end

  describe('#name') do
    it("tells you its name") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      expect(list.name()).to(eq("Epicodus stuff"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      list.save()
      expect(list.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save lists to the database") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      list.save()
      expect(List.all()).to(eq([list]))
    end
  end

  describe("#tasks") do
    it('returns an empty array if you ask for an empty list') do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      list.save()
      expect(list.tasks()).to(eq([]))
    end

    it('returns all task objects for a given list by its id number') do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      list.save()
      test_task = Task.new({:description => "learn SQL", :list_id => list.id(), :due_date => "2018-10-01" })
      test_task.save()
      test_task2 = Task.new({:description => "learn Ruby", :list_id => list.id(), :due_date => "2014-01-01" })
      test_task2.save()
      expect(list.tasks()).to(eq([test_task2, test_task]))
    end

  end



  describe("#==") do
    it("is the same list if it has the same name") do
      list1 = List.new({:name => "Epicodus stuff", :id => nil})
      list2 = List.new({:name => "Epicodus stuff", :id => nil})
      expect(list1).to(eq(list2))
    end
  end

end
