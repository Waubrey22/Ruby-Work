# frozen_string_literal: true
# S1519006 - William Aubrey

require 'search_in_file'

# This variable is the RegEx used to search for appropriate SSN's in files
searchTerm1519006 = /^[a-zA-Z0-9]{3}-[a-zA-Z0-9]{2}-[a-zA-Z0-9]{4}$/

# This variable is the path, indicated by the user, to search for potential SSN's
path1519006 = ""

# This variable is the list of all unique documents which contain SSNs
arrDocSSN = Array []

# This variable is the list of the number of SSNs each unique document contains
arrDocCount = Array []

# This variable is the list of all documents which contain SSNs
arrFoundDoc = Array []

# This variable is the list of all found SSNs, works in conjunction with arrFoundDoc to state where these come from
arrFoundSSN = Array []

# This section of code allows the user to enter the file path to check, it does not let the user enter no file path
until path1519006 != ""
  puts "Enter the path of the folder to check: "
  path1519006 = STDIN.gets
  path1519006.chop!
  unless Dir.exist?(path1519006)
    puts "Directory does not exist, input another directory"
    path1519006 = ""
  end
end

# This converts the potential '\' in the file path with '/' for future code
path1519006.gsub!('\\','/')

# This code searches a folder and all subfolders for instances of .docx files and stores their directory in an array
file_name = Dir.glob("#{path1519006}/**/*.docx")

# This code extracts the contents of the .docx files into an array
count = 0
file_content = Array []
while count < file_name.size
  file_content.push(SearchInFile.content_of(file_name[count]))
  count += 1
end

# This section of code loops through the contents of the .docx files and compares them to the RegEx, searchTerm1519006
# to see if they contain a SSN
wordFound = false
count = 0
while count < file_content.size
  file_content[count].split.each do |word|
    if word.match(searchTerm1519006)
      arr = file_name[count].split("/")

      # This inserts the name of the document into arrFoundDoc and the SSN into arrFoundSSN
      if wordFound == false
        arrFoundDoc.push(arr[arr.size - 1])
        arrFoundSSN.push(word)

        # This checks if the docx has already been found, if not then it inserts it into arrDocSSN
        # and a value of 0 into arrDocCount
        unless arrDocSSN.include?(arr[arr.size - 1])
          arrDocSSN.push(arr[arr.size - 1])
          arrDocCount.push(0)
        end

        # This increments the number of SSNs found in a particular document by 1
        count2 = 0
        while count2 < arrDocSSN.size
          if arrDocSSN[count2] == arr[arr.size - 1]
            arrDocCount[count2] += 1
          end
          count2 += 1
        end
      end
    end
  end

  wordFound = false
  count += 1
end

# This code checks to see if no SSNs were found, if so then it states as much, if not then it states how many SSNs were found and where
if arrDocCount.size == 0
  puts "There were no SSNs found in the given folder"

  dirPath = File.dirname(__FILE__) + "/result.txt"
  outFile = File.new(dirPath, "w")
  outFile.puts "There were no SSNs found in the given folder"
  outFile.close
else
  # This code creates a String called output, which is used to store the unique names of documents which contained SSNs
  # for outputting to the user
  count = 0
  while count < arrDocSSN.size
    if count == 0
      output = arrDocSSN[count]
    else
      output = output + ", " + arrDocSSN[count]
    end
    count += 1
  end

  puts "The documents which held SSNs are: " + output

  puts "SSNs were found in: " + arrDocSSN.size.to_s + " documents"

  # This code creates a String called output, which is used to store the unique names of documents and the number of SSNs
  # each contained for outputting to the user
  count = 0
  while count < arrDocSSN.size
    if count == 0
      output = arrDocSSN[count] + " has " + arrDocCount[count].to_s + " SSN \n"
    else
      output = output + arrDocSSN[count] + " has "+ arrDocCount[count].to_s + " SSN \n"
    end
    count += 1
  end

  puts "With regards to SSNs per document:\n" + output

  # This code creates a file called result.txt and places it within the working folder for
  dirPath = File.dirname(__FILE__) + "/result.txt"
  outFile = File.new(dirPath, "w")
  count = 0
  while count < arrFoundDoc.size
    outFile.puts "#{count + 1}. " + arrFoundSSN[count] + " " + arrFoundDoc[count]
    count += 1
  end
  outFile.close
end