require "./config/environment"
use Rack::MethodOverride
use SubjectsController
use StudentsController
run ApplicationController
