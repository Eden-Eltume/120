require 'fileutils'

copy_and_paste = <<~NAMES
1   Fix the Program - Mailable  completed
2   Fix the Program - Drivable  completed
3   Complete The Program - Houses   completed
4   Reverse Engineering   completed
5   What Will This Do?  completed
6   Comparing Wallets   completed
7   Pet Shelter   completed
8   Fix The Program - Expander  completed
9   Moving  completed
10  Nobility  completed
NAMES

def generate_filenames(heredoc, filetype)
  heredoc
    .split("\n")
    .map do |filename| 
      filename = filename.gsub(/\s+(completed|Not completed)$/, '');
      name_parts = filename.match(/(\d+)\s+(.*)/)
      number = name_parts[1]
      exercise_name = name_parts[2]
      if filetype == '.js'
        camel_case(number, exercise_name, '.js')
      elsif filetype == '.rb'
        snake_case(number, exercise_name, '.rb')
      end
    end.each do |filename| 
      FileUtils.touch(filename)
    end
end

def camel_case(file_number, exercise_name, ext)
  file_number = file_number.to_i < 10 ? "0#{file_number}_" : "#{file_number}_"
  exercise_name = exercise_name.split(' ').map.with_index do |name, index|
    if index == 0
      name.downcase
    else
      name.capitalize
    end
  end.join

  file_number + exercise_name + ext
end

def snake_case(file_number, exercise_name, ext)
  file_number = file_number.to_i < 10 ? "0#{file_number}_" : "#{file_number}_"
  exercise_name = exercise_name.gsub(/\ /, '_').downcase
  file_number + exercise_name + ext
end

file_type = '.rb'
 
generate_filenames(copy_and_paste, file_type)
