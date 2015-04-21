class MenusController < ApplicationController

	def show
		@menus = Menu.active
	end
end
