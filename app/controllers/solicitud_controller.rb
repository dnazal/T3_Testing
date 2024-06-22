# frozen_string_literal: true

# Controlador para gestionar las solicitudes de compra
class SolicitudController < ApplicationController
  # Muestra las solicitudes y productos asociados del usuario actual
  def index
    @solicitudes = Solicitud.where(user_id: current_user.id)
    @productos = Product.where(user_id: current_user.id)
  end

  # rubocop:disable Metrics/AbcSize
  # Crea una nueva solicitud de compra
  def insertar
    product_id = params[:product_id]
    producto = Product.find(product_id)

    # Verificar si el producto es una cancha
    if producto.categories == 'Cancha'
      # Verificar si ya no hay stock disponible
      if producto.stock.to_i < 1
        flash[:error] = 'No hay stock disponible para la reserva!'
        redirect_to "/products/leer/#{product_id}"
        return
      end

      solicitud = Solicitud.new(
        status: 'Pendiente',
        product_id: product_id,
        user_id: current_user.id,
        reservation_info: "Solicitud de reserva para el día #{producto.fecha}, de #{producto.hora_inicio.strftime('%H:%M')} a #{producto.hora_fin.strftime('%H:%M')}",
        stock: 1 # Proporcionar un valor predeterminado para stock
      )

      if solicitud.save
        producto.stock = producto.stock.to_i - 1
        producto.save!
        flash[:notice] = 'Reserva creada correctamente!'
        redirect_to products_index_path
      else
        flash[:error] = 'Hubo un error al crear la reserva!'
        Rails.logger.debug "Error al guardar la solicitud: #{solicitud.errors.full_messages.join(', ')}"
        redirect_to "/products/leer/#{product_id}"
      end
    else
      flash[:error] = 'Este producto no es una cancha!'
      redirect_to "/products/leer/#{product_id}"
    end
  end
  # rubocop:enable Metrics/AbcSize

  # Elimina una solicitud de compra
  def eliminar
    @solicitud = Solicitud.find(params[:id])
    producto = Product.find(@solicitud.product_id)
    producto.stock = producto.stock.to_i + @solicitud.stock.to_i

    if @solicitud.destroy && producto.update(stock: producto.stock)
      flash[:notice] = 'Solicitud eliminada correctamente!'
    else
      flash[:error] = 'Hubo un error al eliminar la solicitud!'
    end
    redirect_to '/solicitud/index'
  end

  # Actualiza el estado de una solicitud a "Aprobada"
  def actualizar
    @solicitud = Solicitud.find(params[:id])
    @solicitud.status = 'Aprobada'

    if @solicitud.update(status: @solicitud.status)
      flash[:notice] = 'Solicitud aprobada correctamente!'
    else
      flash[:error] = 'Hubo un error al aprobar la solicitud!'
    end
    redirect_to '/solicitud/index'
  end

  private

  # Permite los parámetros necesarios para la creación de una solicitud
  def parametros
    params.require(:solicitud).permit(:stock, :reservation_datetime).merge(product_id: params[:product_id])
  end
end
