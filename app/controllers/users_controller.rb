class UsersController < ApplicationController
  def participate

    respond_to do |format|
      if current_user.update_attributes(params[:user])
        format.html { redirect_to "/permalink/#{current_user.id}", notice: 'Cadastro com sucesso.' }
        format.json { render json: current_user, status: :modified, location: current_user }
      else
        format.html { render template: "pages/home" }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end

  end

  def permalink
  	@user = User.find(params[:id])

  	respond_to do |format|
      format.html 
      format.json { render json: @user }
    end
  end
end
