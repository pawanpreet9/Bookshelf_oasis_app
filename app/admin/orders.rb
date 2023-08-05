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
  permit_params :total, :customer_id, :description

  filter :total
  filter :customer
  filter :description
  filter :created_at

  index do
    selectable_column
    column :id
    column :description
    column :total
    column :customer
    column :books do |order|
      order.order_items.joins(:book).pluck(:title).join(', ')
    end
    actions
  end

  form do |f|
    f.inputs 'Order Details' do
      f.input :description
      f.input :total
      f.input :customer
    end
    f.actions
  end
end
