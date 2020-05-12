json.set! @address.id do
  json.extract! @address, :line1,:line2,:city,:state,:country,:zipcode
end
