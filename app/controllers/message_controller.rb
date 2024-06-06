class MessageController < ApplicationController
  load_and_authorize_resource

  def insertar
    @product = Product.find(params[:product_id])
    @message = Message.new(message_params)
    @message.product = @product
    @message.user = current_user
    @message.parent = Message.find(params[:ancestry]) if params[:ancestry].present?

    if @message.save
      flash[:notice] = 'Pregunta creada correctamente!'
    else
      flash[:error] = 'Hubo un error al guardar la pregunta. ¡Completa todos los campos solicitados!'
    end
    redirect_to "/products/leer/#{params[:product_id]}"
  end

  def leer
    @message = Message.find(params[:id])
    render :leer
  end

  def eliminar
    @message = Message.find(params[:message_id])
    @message.destroy
    redirect_to "/products/leer/#{params[:product_id]}"
  end

  private

  def message_params
    params.require(:message).permit(:body, :ancestry).merge(product_id: params[:product_id])
  end
end
