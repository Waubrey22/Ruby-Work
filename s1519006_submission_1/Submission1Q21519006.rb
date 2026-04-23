# frozen_string_literal: true
# S1519006 - William Aubrey

# The variables are initialised here for later use in the program
path1519006 = ""
name1519006 = ""

# This section asks the user to enter the folder path to check if it exists
# it is protected from users entering nothing
until path1519006 != ""
  puts "Enter the path of the folder to check: "
  path1519006 = STDIN.gets
  path1519006.chop!
end

# This section asks the user to enter the name of the folder to check if it exists
# it is protected from users entering nothing
until name1519006 != ""
  puts "Enter the name of the folder to check: "
  name1519006 = STDIN.gets
  name1519006.chop!
end

# This section of code exists to add a '\' to the end of a folder path in case of situations
# where the user does not include one, such as if they were to copy the folder path from file explorer,
# it then concats the strings together to put them in a readable format for the '.exist?' method
if path1519006 =~ /\$/
  path1519006.concat(name1519006)
else
  path1519006.concat('/',name1519006)
end

# This section of code checks if the folder path exists, and if so displays the contents of said folder
# The STDIN exists as a simple way to pause the program to wait for an input from the user without using said input
if File.exist?(path1519006)
  puts "The folder exists, press enter to view the folders contents"
  STDIN.gets
  puts Dir.entries(path1519006)
else
  puts "ERROR 1519006 - The designated folder does not exist"
end