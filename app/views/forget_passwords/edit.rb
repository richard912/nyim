class Views::ForgetPasswords::Edit < Application::Widget
  def widget_content
    h1 'Change your password'
    semantic_form_for(resource, :as => resource_name, :url => password_path(resource_name), :html => { :method => :put }) do |f|
      rawtext devise_error_messages!
      f.inputs do
        f.input :reset_password_token, :as => :hidden
        f.input :password, :label => "New password"
        f.input :password_confirmation, :label => "Confirm new password"
      end
      formtastic_button(f, "Change my password")
    end
  end
end
