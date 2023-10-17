module ApplicationHelper
    def name_project(uppercase: false)
        name = Rails.application.class.module_parent_name.to_s
        name = name.upcase if uppercase
        name
    end
end
