class Agencia < ApplicationRecord
  has_many :participacoes
end

# == Schema Information
#
# Table name: agencias
#
#  id               :integer          not null, primary key
#  nome             :string
#  email            :string
#  longitude        :string(255)
#  latitude         :string(255)
#  data_de_abertura :date
#  endereco         :string
#  rede_id          :integer
#
