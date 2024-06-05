require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user.name = nil
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("no puede estar en blanco")
    end

    it 'is not valid with a name shorter than 2 characters' do
      user.name = 'A'
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("es demasiado corto (2 caracteres mínimo)")
    end

    it 'is not valid with a name longer than 25 characters' do
      user.name = 'A' * 26
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("es demasiado largo (25 caracteres máximo)")
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("no puede estar en blanco")
    end

    it 'is not valid con un email duplicado' do
      create(:user, email: user.email)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("ya está en uso")
    end
  end



  describe '#admin?' do
    it 'returns true if the user role is admin' do
      user.role = 'admin'
      expect(user.admin?).to be_truthy
    end

    it 'returns false if the user role is not admin' do
      user.role = 'user'
      expect(user.admin?).to be_falsey
    end
  end

  describe '#password_required?' do
    it 'returns true if the user is new or password is present' do
      new_user = build(:user)
      expect(new_user.password_required?).to be_truthy

      existing_user = create(:user)
      existing_user.password = 'newpassword'
      expect(existing_user.password_required?).to be_truthy
    end

    
  end

  describe '#validate_password_strength' do
    it 'adds an error if the password does not meet the strength requirements' do
      weak_password_user = build(:user, password: 'weakpass')
      weak_password_user.validate_password_strength
      expect(weak_password_user.errors[:password]).to include('no es válido incluir como minimo una mayuscula, minuscula y un simbolo')
    end

    it 'does not add an error if the password meets the strength requirements' do
      strong_password_user = build(:user, password: 'StrongPass1!')
      strong_password_user.validate_password_strength
      expect(strong_password_user.errors[:password]).to be_empty
    end
  end

  describe '#validate_new_wish_product' do
    it 'adds an error if the last wished product does not exist' do
      user.deseados << 999999 # Assuming this product ID does not exist
      user.validate_new_wish_product
      expect(user.errors[:deseados]).to include('el articulo que se quiere ingresar a la lista de deseados no es valido')
    end

    
  end
end
