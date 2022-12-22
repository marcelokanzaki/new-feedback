FactoryBot.define do
  factory :avaliacao do
    responsabilidade { 1 }
    comprometimento { 1 }
    produtividade { 1 }
    atendimento_humanizado { 1 }
    participacao { nil }
  end
end
