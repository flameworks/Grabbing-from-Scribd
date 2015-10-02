textdocs = 'a.txt'
download_folder = 'downloaded_files'
final_id = '#scribdgrabber'
store = []
File.foreach( textdocs ) do |line|
	if line.include?("docManager.assetPrefix = ")
		min_point = line.index(" = ")
		min_ending = line.index(";")
		final_id = line[min_point+4 ... min_ending-1]
	end
	break if final_id != '#scribdgrabber'
end
File.foreach( textdocs ) do |line|
	if line.include?("jsonp") || (line.include?(final_id) && line.include?("jpg"))
		if line.include?("jsonp")
			unique_num = line.index("pages/")
			unique_ending = line.index(".jsonp")
			store.push(line[unique_num+6...unique_ending])
		else 
			unique_num = line.index("images/") #instant dl
			unique_ending = line.index(".jpg")
			store << line[unique_num+7...unique_ending]
		end
	end
end
max_pages = store.count
require 'net/http'
total_time=0
Net::HTTP.start("html.scribdassets.com") { |http|
	(1 .. max_pages).each do |i|
		unique_ID = store[i].to_s
		download_path = "/"+final_id+"/images/"+unique_ID+".jpg"
		loading_time = Time.now
		resp = http.get(download_path)
		File.open("./downloaded_files/page#{i}.jpg","wb") { |file|
			file.write(resp.body)
		}
		total_time += Time.now - loading_time
		average_time = total_time/i.to_f
		puts "Downloaded file #{i} of #{max_pages}, Estimated time left: #{((max_pages-i)*average_time).round(2)} secs"
	end #view-source:http://www.scribd.com/doc/253790910/Options-Futures-and-Other-Derivatives-7e-by-Hull-Solutions-Manual#scribd
}
