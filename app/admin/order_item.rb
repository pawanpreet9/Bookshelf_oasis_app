# app/admin/order_item.rb

ActiveAdmin.register OrderItem do
  # Define the permitted parameters for assignment
  permit_params :book_id, :quantity
  filter :book_id, label: 'Book ID'
  filter :quantity, label: 'Quantity'

  index do
    selectable_column
    id_column
    column :book do |order_item|
      order_item.book.title
    end
    column :quantity
    column :book_price do |order_item|
      order_item.book.current_price # Show the current book price from the Book model
    end
    column :gst_rate do |order_item|
      order_item.tax_rate_history&.gst_rate || order_item.book_price_history&.province&.current_gst_rate # Show the current or historical GST rate
    end
    column :pst_rate do |order_item|
      order_item.tax_rate_history&.pst_rate || order_item.book_price_history&.province&.current_pst_rate # Show the current or historical PST rate
    end
    column :hst_rate do |order_item|
      order_item.tax_rate_history&.hst_rate || order_item.book_price_history&.province&.current_hst_rate # Show the current or historical HST rate
    end


    actions
  end

end
