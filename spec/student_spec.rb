require './student'

describe Student do
  describe ".pick" do
    before(:each) do
      Student.class_variable_set :@@uncalled, []
    end
    it "returns a student" do
      student = Student.pick('c29')
      expect(student).to be_a Student
    end
    context "when run as many times as there are students" do
      it "picks each student only once" do
        student_count = Student.roster('c29').count
        picked = []

        student_count.times{ picked << Student.pick('c29') }

        expect(picked).to eq(picked.uniq)
      end
    end
    context "when run 10,000 times" do
      it "distributes picks evenly" do
        distribution = Hash.new(0)

        10_000.times do
          distribution[Student.pick('c29').name] += 1
        end

        max = distribution.values.max
        min = distribution.values.min

        expect(max).to be_within(1).of(min)
      end
    end
  end
end
