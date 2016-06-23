require 'bundler'
Bundler.require
require 'asana'

#make sure to store your access token in ENV variables 
#do not publish access token to version control  
access_token = your_access_token

client = Asana::Client.new do |c|
  c.authentication :access_token, access_token
end

#GET request to API.  Client is an object created by the API's code library. 
tasks = client.get("/projects/104877489826899/tasks?opt_fields=completed_at,name")

#parse the response
data = tasks.body['data']

#set date range variables for desired start_date and end_date 
start_date = "2016-06-01"
end_date = "now"

#create array to hold the tasks that meet your parameters 
completed_tasks_between_dates = []

#iterate through the array of task hashes
data.each do |task_hash|
	#if statement to check if the completed_at value is not nil and is between the date range
	if task_hash["completed_at"] != nil && task_hash["completed_at"] < end_date && task_hash["completed_at"] > start_date
		completed_tasks_between_dates << task_hash
	end	
end

#print completed task names between date range
completed_tasks_between_dates.each do |task|
	puts task["name"]
end

#return the array of completed tasks between date range
completed_tasks_between_dates