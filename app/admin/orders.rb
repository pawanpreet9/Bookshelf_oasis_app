# app/admin/orders.rb
ActiveAdmin.register Order do
  permit_params  :customer_id,:address, :city,:postal_code


  filter :customer

  filter :created_at

  index do
    selectable_column
    column :id

    column :customer
    column :address
    column :city
    column :postal_code
    column :province do |order|
      link_to order.province.name, admin_province_path(order.province) # Link to the province page
    end
    column :books do |order|
      order.order_items.joins(:book).pluck(:title).map { |title| link_to(title, admin_book_path(Book.find_by(title: title))) }.join(', ').html_safe
    end


    column :order_total do |order|
      number_to_currency(order.total_price)
    end
    column :gst_rate do |order|
      "#{order.province.gst_rate || 0}%"
    end
    column :pst_rate do |order|
      "#{order.province.pst_rate || 0}%"
    end
    column :hst_rate do |order|
      "#{order.province.hst_rate || 0}%"
    end
    actions
  end

  form do |f|
    f.inputs 'Order Details' do


      f.input :customer
    end
    f.actions
  end
end
