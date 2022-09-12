class SessionsController < ApplicationController
def index
    session[:pageviews_remaining] ||= 3
    cookies[:cookies_hello] ||= 'is this working or not'
    render json{ session: session}
end
end
