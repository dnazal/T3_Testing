# app/controllers/contact_message_controller.rb
class ContactMessageController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact_message, only: [:actualizar, :eliminar]
  before_action :authorize_admin!, only: [:eliminar]

  def actualizar
    if @contact_message.update(contact_message_params)
      flash[:notice] = 'Mensaje de contacto actualizado correctamente!'
      redirect_to contacto_path
    else
      flash[:error] = 'Hubo un error al actualizar el mensaje de contacto!'
      redirect_to contacto_path
    end
  end

  def eliminar
    @contact_message.destroy
    flash[:notice] = 'Mensaje de contacto eliminado correctamente!'
    redirect_to contacto_path
  end

  private

  def set_contact_message
    @contact_message = ContactMessage.find(params[:id])
  end

  def contact_message_params
    params.require(:contact_message).permit(:name, :mail, :title, :body)
  end

  def authorize_admin!
    redirect_to(root_path, alert: 'No autorizado') unless current_user.admin?
  end
end
