# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_cart

  def current_cart
    @current_cart ||= Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = @current_cart.id
    @current_cart
  end
end
