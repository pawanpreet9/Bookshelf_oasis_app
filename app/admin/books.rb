# frozen_string_literal: true

ActiveAdmin.register Book do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :description, :quantity, :pages, :price, :image, :publisher, :publication_date, :author_id, :genre_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :quantity, :pages, :price, :image, :publisher, :publication_date, :author_id, :genre_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :title, :description, :quantity, :pages, :price, :image, :publisher, :publication_date, :author_id,
                genre_ids: []

  index do
    selectable_column
    id_column
    column :title
    column :author
    column :genres
    column :price
    column :created_at
    actions
  end

  filter :title
  filter :author
  filter :genres
  filter :price
  filter :created_at

  form do |f|
    f.inputs 'Book Details' do
      f.input :title
      f.input :description
      f.input :quantity
      f.input :pages
      f.input :price
      f.input :image, as: :file
      f.input :publisher
      f.input :publication_date
      f.input :author
      f.input :genres, as: :check_boxes
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :quantity
      row :pages
      row :price
      row :publisher
      row :publication_date
      row :author
      row :genres
      row :image do |i|
        if i.image.attached?
          image_tag i.image
        else
          'Image not added.'
        end
      end
    end
  end
end
