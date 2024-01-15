if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create!(
    name: 'IOS client',
    uid: 'iWUUiZ_uieHIwEjCmP2vg_RMlV4sfUzy3gutJolZ1VI',
    secret: 'KTg0K-iiYweu8LKmT_6h0xdVlqfxQL_-qH9Uu6mClyE',
    redirect_uri: '',
    scopes: ''
  )
end

if User.count.zero?
  User.create!(
    email: 'thanglearndevops@gmail.com',
    password: 'thang123'
    # password: BCrypt::Password.create('thang123')
  )
end
