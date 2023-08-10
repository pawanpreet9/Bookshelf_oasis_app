# frozen_string_literal: true

class ContactController < ApplicationController
  def show
    add_breadcrumb 'Home', :root_path
    add_breadcrumb 'Contact Us', contact_path
    @contact = Contact.first
  end
end
