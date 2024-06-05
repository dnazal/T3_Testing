# spec/models/contact_message_spec.rb
require 'rails_helper'

RSpec.describe ContactMessage, type: :model do
  subject { described_class.new(title: 'Consulta', body: 'Quisiera más información sobre su producto.', name: 'Juan Pérez', mail: 'juan.perez@example.com') }

  describe 'validaciones' do
    it 'es válido con atributos válidos' do
      expect(subject).to be_valid
    end

    it 'no es válido sin un título' do
      subject.title = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:title]).to include("no puede estar en blanco")
    end

    it 'no es válido con un título demasiado largo' do
      subject.title = 'a' * 51
      expect(subject).not_to be_valid
      expect(subject.errors[:title]).to include("es demasiado largo (50 caracteres máximo)")
    end

    it 'no es válido sin un cuerpo' do
      subject.body = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:body]).to include("no puede estar en blanco")
    end

    it 'no es válido con un cuerpo demasiado largo' do
      subject.body = 'a' * 501
      expect(subject).not_to be_valid
      expect(subject.errors[:body]).to include("es demasiado largo (500 caracteres máximo)")
    end

    it 'no es válido sin un nombre' do
      subject.name = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:name]).to include("no puede estar en blanco")
    end

    it 'no es válido con un nombre demasiado largo' do
      subject.name = 'a' * 51
      expect(subject).not_to be_valid
      expect(subject.errors[:name]).to include("es demasiado largo (50 caracteres máximo)")
    end

    it 'no es válido sin un correo electrónico' do
      subject.mail = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:mail]).to include("no puede estar en blanco")
    end

    it 'no es válido con un correo electrónico inválido' do
      subject.mail = 'correo_invalido'
      expect(subject).not_to be_valid
      expect(subject.errors[:mail]).to include('no es válido')
    end

    it 'no es válido con un correo electrónico demasiado largo' do
      subject.mail = 'a' * 41 + '@example.com'
      expect(subject).not_to be_valid
      expect(subject.errors[:mail]).to include("es demasiado largo (50 caracteres máximo)")
    end

    it 'es válido sin un teléfono' do
      subject.phone = nil
      expect(subject).to be_valid
    end

    it 'no es válido con un teléfono en un formato incorrecto' do
      subject.phone = '123456789'
      expect(subject).not_to be_valid
      expect(subject.errors[:phone]).to include('El formato del teléfono debe ser +56XXXXXXXXX')
    end

    it 'es válido con un teléfono en un formato correcto' do
      subject.phone = '+56912345678'
      expect(subject).to be_valid
    end
  end
end
