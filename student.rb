class Student
  attr_reader :name

  @@uncalled = []

  def initialize(attributes={})
    @name = attributes[:name]
    @file = attributes[:file]
    @@uncalled << self
  end

  def two_truths_and_a_lie
    File.readlines(@file)
  end

  def self.pick(cohort)
    roster(cohort).each{ |attrs| new(attrs) } if @@uncalled.empty?
    @@uncalled.shuffle!.pop
  end

  def self.all(cohort)
    roster(cohort).map{ |attrs| new(attrs) }
  end

  def to_json(options={})
    {
      name: name,
      two_truths_and_a_lie: sanitized_assertions.map do |assertion|
        { assertion: assertion.gsub('~', ''), status: !assertion.include?('~') }
      end
    }
  end

  private

  def self.roster(cohort)
    # turn c29 into c29.md
    file = cohort + '.md'
    # read through c29.md, strip out the white space,
    # and drop the first two lines
    File.readlines(file).map(&:strip).drop(2).map do |line|
      # map over the lines and pull out the names and files
      {
        name: line.delete_prefix("* [").split("]").first,
        file: line.split("(").last.delete_suffix(")")
      }
    end
    # returns an array of hashes
  end

  def sanitized_assertions
    two_truths_and_a_lie.map do |line|
      line.sub('* ', '').strip
    end
  end
end
