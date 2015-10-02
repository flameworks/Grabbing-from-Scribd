# Grabbing-from-Scribd
Downloading PDFs from Scribd without a paid account.

NOTE: Any downloading files from Scribd are subject to General Terms of use that scribd has stated, and the terms can be found here http://support.scribd.com/forums/33939/entries/25459


How to use:
This code runs in Ruby, and uses Class: Net::HTTP.

After finding your desired PDF from Scribd, copy the entire page's source code through "View Source", into "a.txt". After which, run the code. It will proceed to download the entire PDF, in images (jpg format), into the "downloaded_files" folder. Proceed to use a PDF compiler to compile your images into a PDF File.

