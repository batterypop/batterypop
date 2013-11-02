ActiveAdmin.register UsernameWord do
	menu :parent => "Users"

	form do |f|
		f.inputs "User Name Words" do
			f.input :kind, :as => :select, :collection => ['adverb', 'noun']
			f.input :word
		end
		f.actions
	end


end
