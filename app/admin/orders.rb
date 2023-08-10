# frozen_string_literal: true

# app/admin/orders.rb
ActiveAdmin.register Order do
  permit_params :customer_id, :address, :city, :postal_code

  filter :customer
  filter :created_at

  index do
    selectable_column
    column :id
    column :customer_number do |order|
      link_to order.customer.id, admin_customer_path(order.customer)
    end
    column :customer_email do |order|
      order.customer.email
    end
    column :address
    column :city
    column :postal_code
    column :province do |order|
      link_to order.province.name, admin_province_path(order.province) # Link to the province page
    end
    column :books_and_quantities do |order|
      order.order_items.map { |item| "#{item.book.title} (#{item.quantity})" }.join(', ').html_safe
    end
    column :order_total do |order|
      number_to_currency(order.total)
    end
    column :gst_rate do |order|
      "#{order.gst_rate || 0}%"
    end
    column :pst_rate do |order|
      "#{order.pst_rate || 0}%"
    end
    column :hst_rate do |order|
      "#{order.hst_rate || 0}%"
    end
    actions
  end

  form do |f|
    f.inputs 'Order Details' do
      f.input :customer
      # You can add more input fields here as needed
    end
    f.actions
  end
end
