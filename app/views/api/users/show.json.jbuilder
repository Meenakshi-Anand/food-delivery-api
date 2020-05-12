json.set! @user.id do
  json.extract! @user, :name,:email,:contact_no,:entity_type
end
