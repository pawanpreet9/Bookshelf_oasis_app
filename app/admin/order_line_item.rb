
ActiveAdmin.register OrderLineItem do
  # Define the permitted parameters for assignment
  permit_params :book_id, :quantity, :price


end
