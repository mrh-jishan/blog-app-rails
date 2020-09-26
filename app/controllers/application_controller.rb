class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler

    def routing_error(error = 'Routing error', status = :not_found, exception=nil)
        render :json => 'Routing Error', :status => 401
    end
end
