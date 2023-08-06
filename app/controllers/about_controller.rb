# frozen_string_literal: true

class AboutController < ApplicationController
  def show
    @about = About.first
  end
end
