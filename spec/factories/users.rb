FactoryGirl.define do
  factory :user do
    sequence(:name) { "Usuario Teste #{n}" }
    sequence(:email) { "teste#{n}@teste.com.br" }
    sequence(:password) { "123#{n}" } 
  end
end
