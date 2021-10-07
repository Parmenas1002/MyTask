module Admin::TagsHelper
    def choose_new_or_edit
        if action_name == 'new'
            admin_tags_path
        elsif action_name == 'edit'
            admin_tag_path    
        end
    end
end
