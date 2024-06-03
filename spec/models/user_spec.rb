# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  # Test validations
  describe 'Validations' do
    let(:user) do
 User.new(name: 'Diego Nazal', email: 'diegonazal@example.com', password: 'Secure123!', 
          password_confirmation: 'Secure123!')
    end

    def validate_password_strength
        return if password.blank?
      
        regex = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/
        errors.add(:password, 'no es válido incluir como mínimo una mayúscula, minúscula y un símbolo') unless password.match(regex)
      end
      

    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user.name = nil
      user.valid?
      expect(user.errors[:name]).to include("no puede estar en blanco")
    end

    it 'is not valid with a short name' do
      user.name = 'A'
      user.valid?
      expect(user.errors[:name]).to include("es demasiado corto (2 caracteres mínimo)")
    end

    it 'is not valid without an email' do
      user.email = nil
      user.valid?
      expect(user.errors[:email]).to include("no puede estar en blanco")
    end

    it 'is not valid with a non-unique email' do
      duplicate_user = user.dup
      duplicate_user.save
      user.email = duplicate_user.email
      user.valid?
      expect(user.errors[:email]).to include("ya está en uso")
    end

      
      
      context 'wishlist validations' do
        it 'does not allow invalid product IDs in wishlist' do
          user.deseados << 99999 
          user.valid?
          expect(user.errors[:deseados]).to include('el articulo que se quiere ingresar a la lista de deseados no es valido')
        end
      end
  end



  # Additional methods
  describe '#admin?' do
    it 'returns true if the user is an admin' do
      user = User.new(role: 'admin')
      expect(user.admin?).to be true
    end

    it 'returns false if the user is not an admin' do
      user = User.new(role: 'user')
      expect(user.admin?).to be false
    end
  end
end



  
