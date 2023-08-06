# frozen_string_literal: true

ActiveAdmin.register OrderItem do
  # Define the permitted parameters for assignment
  permit_params :book_id, :quantity
end
