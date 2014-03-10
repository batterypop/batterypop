ActiveAdmin.register User do
	menu :parent => "Users"

	before_filter :only => [:show, :destroy, :edit, :update] do
	    @user = User.friendly.find(params[:id])
	end

end