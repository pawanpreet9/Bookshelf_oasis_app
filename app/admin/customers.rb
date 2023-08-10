# frozen_string_literal: true

# app/admin/customers.rb
ActiveAdmin.register Customer do
  permit_params :name, :address, :city, :postal_code, :email, :province_id

  filter :name
  filter :email
  filter :province

  index do
    selectable_column
    column :id
    column :name
    column :email
    column :address
    column :city
    column :postal_code
    column :province
    actions
  end

  form do |f|
    f.inputs 'Customer Details' do
      f.input :name
      f.input :email
      f.input :address
      f.input :city
      f.input :postal_code
      f.input :province
    end
    f.actions
  end
end
