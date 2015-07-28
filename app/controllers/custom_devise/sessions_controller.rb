class CustomDevise::SessionsController < Devise::SessionsController
  protected

  def DELETE
    super
    redirect_to '/'
  end

  def after_sign_out_path_for(resource_or_scope)
    '/'
  end
end
