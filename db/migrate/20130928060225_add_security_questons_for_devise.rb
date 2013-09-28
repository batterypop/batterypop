class AddSecurityQuestonsForDevise < ActiveRecord::Migration
  def change
	create_table :security_questions do |t|
		t.string :locale, :null => false
		t.string :name, :null => false
	end

	# SecurityQuestion.create! locale: :en, name: 'Wie lautet der Geburstname Ihrer Mutter?'
	# SecurityQuestion.create! locale: :en, name: 'Wo sind sie geboren?'
	# SecurityQuestion.create! locale: :en, name: 'Wie lautet der Name Ihres ersten Haustieres?'
	# SecurityQuestion.create! locale: :en, name: 'Was ist Ihr Lieblingsfilm?'
	# SecurityQuestion.create! locale: :en, name: 'Was ist Ihr Lieblingsbuch?'
	# SecurityQuestion.create! locale: :en, name: 'Was ist Ihr Lieblingstier?'
	# SecurityQuestion.create! locale: :en, name: 'Was ist Ihr Lieblings-Reiseland?'

  end
end
