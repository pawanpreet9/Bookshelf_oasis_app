# frozen_string_literal: true

class ContactController < ApplicationController
  def show
    @contact = Contact.first
  end
end
