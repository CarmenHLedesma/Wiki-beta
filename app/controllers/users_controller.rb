class UsersController < ApplicationController
  # Creamos un índice para gestionar los usuarios de nuestra aplicación
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

end


private

def user_params
  params.require(:user).permit(:email, :name, :avatar)
end