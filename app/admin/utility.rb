ActiveAdmin.setup do |config|
    config.namespace :admin do |admin|
      admin.build_menu :utility_navigation do |menu|
        menu.add label: "ActiveAdmin.info", url: "http://www.activeadmin.info", html_options: { target: :blank }
        admin.add_logout_button_to_menu menu # can also pass priority & html_options for link_to to use
      end
    end
  end