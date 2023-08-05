# frozen_string_literal: true

ActiveAdmin.register Order do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :order_date, :total, :description, :customer_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:order_date, :total, :description, :customer_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :order_date, :total, :customer_id, :description

  filter :order_date
  filter :total
  filter :customer
  filter :description
  filter :created_at

  form do |f|
    f.inputs 'Order Details' do
      f.input :order_date
      f.input :description
      f.input :total
      f.input :customer
    end
    f.actions
  end
end
