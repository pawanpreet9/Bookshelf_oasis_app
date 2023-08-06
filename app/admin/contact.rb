# frozen_string_literal: true

ActiveAdmin.register Contact do
  permit_params :title, :content
  controller do
    def new
      if Contact.exists?

        flash[:notice] = 'A contact data already exists. You cannot create a new one. You can edit this!'
        redirect_to admin_contact_path(Contact.first)
      else
        super
      end
    end
  end
  form do |f|
    f.inputs do
      f.input :title
      f.input :content, as: :text
    end
    f.actions
  end
end
