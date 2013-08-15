# class Admin::AvatarController < ApplicationController

#   def create
#     puts " $&$&$&  ATTEMPT  $*$*$*"
#     @avatar = Avatar.create(avatar_params)
#   end

# def update
#   puts " *** update start controller ***"
#   puts params.inspect
#    puts " *** update end controller ***"
# end

#   def avatar_params
#     # params.require(:avatar).permit(:image, :name)
#     puts " *** START ***"
#     puts params.inspect
#     puts " **** END "
#     params.require(:avatar).permit(:name, params[:avatar][:image]["0"][:tempfile], params[:avatar][:image]["0"][:original_filename], params[:avatar][:image]["0"][:content_type], params[:avatar][:image]["0"][:headers])
#       # :image => [:tempfile, :original_filename, :content_type, :headers])
# # params[:avatar][:image]["0"][:tempfile]
# # params.require(:screenshot).permit(params[:screenshot][:assets_attributes]["0"][:filename] )
#    end
   
# end
