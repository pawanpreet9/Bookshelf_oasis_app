# frozen_string_literal: true

ActiveAdmin.register About do
  permit_params :title, :content
  controller do
    def new
      if About.exists?

        flash[:notice] = 'A about page data already exists. You cannot create a new one. You can edit this!'
        redirect_to admin_about_path(About.first)
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
