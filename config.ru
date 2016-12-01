require "./config/environment"
use Rack::MethodOverride
use TeachersController
use SubjectsController
use StudentsController
run ApplicationController
