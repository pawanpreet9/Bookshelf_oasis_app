# frozen_string_literal: true

class AboutController < ApplicationController
  def show
    add_breadcrumb 'Home', :root_path
    add_breadcrumb 'About Us', about_path
    @about = About.first
  end
end
