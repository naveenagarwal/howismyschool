ActiveAdmin.register School do


  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  controller do
    def permitted_params
      params.permit(school: [:name, regestrar_details: [:email, :first_name, :last_name, :phone, :address] ])
    end
  end

  form do |f|
    f.inputs name: "School" do
      f.input :name, label: "Name"
      # f.inputs "Regestrar Details" do |ff|
      #   ff.input :email
      # end
      f.input :regestrar_details, label: "Regestrar Details"
    end
    f.actions
  end

end
