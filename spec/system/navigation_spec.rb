require 'rails_helper'

RSpec.describe 'Navigation', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  let(:admin) { create(:user, role: 'admin', name: 'Admin User') }
  let!(:product) { create(:product, nombre: 'Producto 1', user: admin) }

  before do
    login_as(admin, scope: :user)
  end

  it 'allows navigation to product details from the product list' do
    visit '/products/index'
    within find("div.card", text: product.nombre) do
      click_link 'Detalles'
    end
    expect(page).to have_current_path("/products/leer/#{product.id}")
  end

  it 'allows navigation to product editing from the product list' do
    visit '/products/index'
    within find("div.card", text: product.nombre) do
      click_link 'Editar'
    end
    expect(page).to have_current_path("/products/actualizar/#{product.id}")
  end

  it 'allows navigation to product creation from the landing page' do
    visit root_path
    click_link 'Ver canchas y productos'
    expect(page).to have_current_path('/products/index')
  end

  it 'allows admin to see and manage pending requests' do
    visit '/solicitud/index'
    within '.section' do
      expect(page).to have_content('Mis solicitudes de reserva y compra pendientes')
    end
  end

  it 'allows creating a new product' do
    visit '/products/crear'
    fill_in 'product[nombre]', with: 'Nuevo Producto'
    select 'Cancha', from: 'product[categories]'
    fill_in 'product[precio]', with: 1000
    fill_in 'product[fecha]', with: Date.today
    fill_in 'product[hora_inicio]', with: '10:00'
    fill_in 'product[hora_fin]', with: '11:00'
    click_button 'Guardar'
    expect(page).to have_content('Nuevo Producto')
  end

  it 'allows updating an existing product' do
    visit "/products/actualizar/#{product.id}"
    fill_in 'product[nombre]', with: 'Producto Actualizado'
    click_button 'Guardar'
    expect(page).to have_content('Producto Actualizado')
  end

  it 'allows deleting a product' do
    visit '/products/index'
    accept_confirm do
      within find("div.card", text: product.nombre) do
        click_button 'Eliminar'
      end
    end
    expect(page).not_to have_content(product.nombre)
  end

  it 'allows viewing product details' do
    visit "/products/leer/#{product.id}"
    expect(page).to have_content(product.nombre)
  end

  it 'shows all products on the product list page' do
    visit '/products/index'
    expect(page).to have_content(product.nombre)
  end

  it 'searches products by name' do
    visit '/products/index'
    fill_in 'search', with: product.nombre
    click_button 'Buscar'
    expect(page).to have_content(product.nombre)
  end

    it 'searches products by category' do
    visit '/products/index'
    select 'Accesorio tecnologico', from: 'category'
    click_button 'Buscar'
    expect(page).to have_content(product.nombre)
  end

end
