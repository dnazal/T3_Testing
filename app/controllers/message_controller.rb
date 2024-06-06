# app/controllers/message_controller.rb
class MessageController < ApplicationController
  before_action :set_message, only: [:eliminar]
  before_action :authenticate_user!, only: [:insertar, :eliminar]

  def leer
    @message = Message.find(params[:id])
    render :leer
  end

  def insertar
    @product = Product.find(params[:product_id])
    @message = Message.new(message_params)
    @message.product_id = @product.id
    @message.user_id = current_user.id
    @message.parent = Message.find(params[:ancestry]) if params[:ancestry].present?

    if @message.save
      flash[:notice] = 'Pregunta creada correctamente!'
    else
      flash[:error] = 'Hubo un error al guardar la pregunta. ¡Completa todos los campos solicitados!'
    end
    redirect_to "/products/leer/#{@product.id}"
  end

  def eliminar
    @message.destroy
    redirect_to "/products/leer/#{params[:product_id]}"
  end

  private

  def set_message
    @message = Message.find(params[:message_id])
  end

  def message_params
    params.require(:message).permit(:body, :ancestry).merge(product_id: params[:product_id])
  end
end
