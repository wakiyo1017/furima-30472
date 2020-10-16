FactoryBot.define do
  factory :order_destination do
    post_number { '111-2222'}
    region_id {2}
    city { '札幌市' }
    street { '1-1-3' }
    apartment { 'コーポ函館' }
    telephone { '00000000000' }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
