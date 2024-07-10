require 'sinatra'
require 'sinatra/json'
require 'sinatra/cors'
require './student'

set :allow_origin, "*"
set :allow_methods, "GET"
set :allow_headers, "content-type,if-modified-since"
set :expose_headers, "location,link"

get '/cohorts/:cohort_id/students' do
  students = Student.all('c'+params[:cohort_id])
  json(students.map(&:to_json))
end

get '/cohorts/:cohort_id/students/random' do
  students = Student.all('c'+params[:cohort_id])
  student = students.sample
  json(student.to_json)
end

get '/part-time-cohorts/:cohort_id/students/random' do
  students = Student.all('pt'+params[:cohort_id])
  student = students.sample
  json(student.to_json)
end
