ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
        panel "Recent Events" do
            table_for Event.order('updated_at desc').limit(5) do |event|
                column :name do |event|
                    link_to event.name, admin_event_path(event)
                end
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
                  link_to event.registers.count, '#'
                end
            end
            strong { link_to "More Events", admin_events_path }
        end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
