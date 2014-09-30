class ApplicationController < ActionController::Base
  require 'rubygems'
  require 'pry' if (Rails.env.development? || Rails.env.test?)
  require 'nokogiri'
  require 'open-uri'
  require 'prawn'


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
