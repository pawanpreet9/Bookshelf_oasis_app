ActiveAdmin.register Customer do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :email, :address
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :address]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :name, :email, :address

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :address

    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :address

  filter :created_at

  form do |f|
    f.inputs 'Customer Details' do
      f.input :name
      f.input :email
      f.input :address

    end
    f.actions
  end
end
