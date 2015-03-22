ActiveAdmin.register Tournament do

  menu :parent => "bPOP Tournaments"# , :priority => 1

  before_filter :only => [:show, :destroy, :edit, :update] do
    @tournament = Tournament.unscoped.friendly.find(params[:id])
  end

  form  do |f|
    f.inputs "Tournament Details" do
      # f.input :creator, :class => 'chosen', :as => :select, :member_label => :displayname, :required => true
      f.input :title, :label => "Show Title", :required => true
      f.input :subtitle, :label => "Show Subtitle", :required => true
      f.input :image,  :hint => f.object.image.present? \
        ? f.template.image_tag(f.object.image.url(:thumb))
      : f.template.content_tag(:span, 'Main show image.')
      f.input :background,  :hint => f.object.background.present? \
        ? f.template.image_tag(f.object.background.url(:thumb))
      : f.template.content_tag(:span, 'No background as yet.')
      f.input :description,  :label => "Description", :as => :rich, :allow_embeds => true
      f.input :episodes, :class => 'chosen', :as => :select, :required => true
    end


      f.has_many :matches do |match|
        match.input :player_one, required: true
        match.input :player_two, required: true
        match.input :first_seat, required: true
        match.input :second_seat, required: true
        match.input :start, required: true, as: :datetime_select
        match.input :finish, required: true, as: :datetime_select
      end


    f.actions
  end

  index do
    column :position
    column :creator do |show|
      link_to show.creator.displayname, admin_creator_path(show.creator)
    end
    # column (:image) {link_to image_tag(@show.image(:thumb)), admin_show_path(@show)}
    column (:image) {|fooimg| image_tag(fooimg.image(:thumb))}
    column  :title
    column (:description) { |foobar| raw(foobar.description) }
    column :single, :as => :check_box
    column :approved

    default_actions
  end

  action_item :only => :show do
    # link_to('View on site', show_path(show))
    # (show_path(show)).inspect
  end

end
