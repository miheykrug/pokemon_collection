class Writers::Json
  def initialize(file_name)
    @file_name = file_name
  end

  def call(data)
    File.open("#{file_name}.json", 'w') do |f|
      f.write(data.to_json)
    end
  end

  private

  attr_reader :file_name
end
