ActiveAdmin.register User do
  config.per_page = 20
  index do
    column :firstname
    column :lastname
    column :gender
    column :default_currency
    column :date_of_birth
    column :events do |user|
      user.events.count
    end
    default_actions
  end

  show do
    attributes_table do
      row :firstname
      row :lastname
      row :gender
      row :default_currency
      row :date_of_birth
      row :events do |user|
        user.events.count
      end
    end
    panel "Registered Events" do
      table_for user.events do
        column :name do |event|
          link_to event.name, admin_event_path(event)
        end
        column :subname
        column :club
        column :city
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
        column :addon_code
      end
    end
    active_admin_comments
  end
end
