require 'fileutils'

copy_and_paste = <<~NAMES
OO Basics: Classes and Objects 1
10/10 Completed
OO Basics: Classes and Objects 2
10/10 Completed
OO Basics: Inheritance
10/10 Completed
OO Basics: Accessor Methods
10/10 Completed
Easy 1
10/10 Completed
Easy 2
10/10 Completed
Medium 1
10/10 Completed
Debugging
0/10 Completed
NAMES

DIGITS = (0..9).to_a.map{|int| int.to_s}
def generate_folder_names(heredoc)
  heredoc
    .split("\n")
    .delete_if do |line| 
      DIGITS.include?(line[0])
    end
end

def generate_folders(names_arr)
    count = 1 
    names_arr.each do |name|
      folder_name = count.to_s + "_" + name
      FileUtils.mkdir(folder_name)
      count += 1
    end
end

names = generate_folder_names(copy_and_paste)
generate_folders(names)