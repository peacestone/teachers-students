require "./config/environment"
use Rack::MethodOverride
use SubjectsController
use TeachersController
use StudentsController
run ApplicationController
