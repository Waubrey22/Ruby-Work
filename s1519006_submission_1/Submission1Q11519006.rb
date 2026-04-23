# frozen_string_literal: true
# S1519006 - William Aubrey

# The variable is initialised here for later use in the program, it exists to count the amount of times 'Ruby' appears
rubyCount = 0

# Firstly the code checks to see if the Story1519006.txt file exists within the file system
if File.exist?("./s1519006_submission_1/Story1519006.txt")
  # If it is found, it creates a variable of said file and reads it line by line and word by word,
  # using a regex to see if the word 'Ruby' exists anywhere in said file, it downcases the words before checking to ensure
  # that words checked simply do not have different casing
  testFile = File.open("./s1519006_submission_1/Story1519006.txt")
  testFile.each do |line|
    line.split.each do |word|
      if word.downcase =~ /ruby/
        rubyCount += 1
      end
    end
  end
  # At this point with the ruby count checked, it closes the file. For whatever reason if I do not close and reopen the file
  # the line by line display in the next section does not work
  testFile.close
  testFile = File.open("./s1519006_submission_1/Story1519006.txt")

  #If there was any 'Ruby' found, it displays the text line by line and states how many times 'Ruby' was found
  if rubyCount > 0
    testFile.each do |line|
      puts line
    end
    puts "In the text, there are " + rubyCount.to_s + " counts of 'Ruby'"
  else
    puts "'Ruby' was not found in the text"
  end

  # It then closes the file
  testFile.close
else
  # If the file cannot be found, it states as such as an error
  puts "ERROR 1519006 - File does not exist"
end