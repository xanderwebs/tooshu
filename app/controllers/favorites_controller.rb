class FavoritesController < ApplicationController
def create
	@favorites = current_user.favorites.build(:favorite_user_id => params[:favorite_user_id])
	if @favorites.save
		flash[:success] = "Added to your favorites!"
		redirect_to user_path(params[:favorite_user_id])
	else
		flash[:error] = "Unable to add friend."
		redirect_to user_path(params[:favorite_user_id])
	end
  end

  def destroy
	@favorite = current_user.favorites.find(params[:id])
	@favorite.destroy
	flash[:error] = "Removed from favorites."
	redirect_to :back
  end
end
