module ContactsHelper
    def choose_c_new
       if action_name == 'new' || action_name == 'confirm'
           confirm_contacts_path
       elsif action name == 'edit'
         contact_path
       end
    end
end
