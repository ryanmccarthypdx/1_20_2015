require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/places_been.rb')
require('./lib/jobs.rb')

get('/place_form') do
  @title = "Places I've Been!"
  @places = Place.all()
  erb(:place_form)
end

post('/place_result') do
  @title = "Success!"
  place_example = params.fetch("place_example")
  place = Place.new(place_example)
  place.save()
  erb(:place_result)
end

get('/job_form') do
  @title = "Jobs I've Had"
  @job_list = Job.all()
  erb(:job_form)
end

post('/job_result') do
  @job_name = params.fetch('job_name')
  @job_title = params.fetch('job_title')
  @job_resp = params.fetch('job_resp')
  job = Job.new(@job_name, @job_title, @job_resp)
  job.save()
  erb(:job_result)
end

post('/job_delete') do
  job_to_delete = params.fetch('job_to_delete')
  @job_to_delete = job_to_delete.to_i()
  Job.delete(@job_to_delete)
  erb(:job_delete)
end

post('/delete_all') do
  Job.clear()
  erb(:delete_all)
end
