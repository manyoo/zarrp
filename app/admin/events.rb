ActiveAdmin.register Event do
  config.per_page = 20
  form :html => { :enctype => "multipart/form-date" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :subname
      f.input :club
      f.input :address
      f.input :phone, :as => :phone
      f.input :email, :as => :email
      f.input :short_desc
      f.input :desc
      f.input :avatar, :as => :file
      f.input :image, :as => :file
      f.input :time
      f.input :price
    end
    f.buttons
  end

  index do
    column :name
    column :subname
    column :club
    column :address
    column :phone
    column :email
    column :short_desc
    column :desc
    column :avatar do |event|
      link_to image_tag(event.avatar.url, :height => '80'), admin_event_path(event)
    end
    column :image do |event|
      link_to image_tag(event.image.url, :height => '80'), admin_event_path(event)
    end
    column :time
    column :price
    column :registers do |event|
      event.registers.count
    end
    default_actions
  end

  show do
    attributes_table do
      row :name
      row :subname
      row :club
      row :address
      row :phone
      row :email
      row :short_desc
      row :desc
      row :avatar do |event|
        link_to image_tag(event.avatar.url, :height => '80'), admin_event_path(event)
      end
      row :image do |event|
        link_to image_tag(event.image.url, :height => '80'), admin_event_path(event)
      end
      row :time
      row :price
      row :registers do |event|
        event.registers.count
      end
    end
    panel "Registers" do
      table_for event.registers do
        column :firstname do |user|
          link_to user.firstname, admin_user_path(user)
        end
        column :lastname do |user|
          link_to user.lastname, admin_user_path(user)
        end
        column :gender
        column :default_currency
        column :date_of_birth
      end
    end
    active_admin_comments
  end
end
