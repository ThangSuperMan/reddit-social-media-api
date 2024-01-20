if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create!(
    name: 'IOS client',
    uid: ENV['MOBILE_CLIENT_ID'],
    secret: ENV['MOBILE_CLIENT_SECRET'],
    redirect_uri: '',
    scopes: ''
  )
end

if User.count.zero? && Rails.env.development?
  User.create!(
    email: 'thanglearndevops@gmail.com',
    password: 'thang123'
  )
end
