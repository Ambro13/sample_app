class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception     #Turn on request forgery protection.  yandex translate -> защита от подделки.
  include SessionsHelper
end
