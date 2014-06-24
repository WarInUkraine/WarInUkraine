# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!({
  first_name: 'Admin',
  last_name:  'Admin',
  email:      'test@example.com',
  password:   '12345678',
  about:      'Developer',
  admin:      true
})

puts 'Admin user created. Email: test@example.com, Password: 12345678'

Static.create!({
  url: 'wanna-post',
  title: 'Хотите публиковать без проверки?', # отправьте смс на короткий номер :P
  html: '<p>Для публикации на нашем сайте без проверки модератором Вам необходимо отправить email на адрес "<a href="mailto:warinukraine@gmail.com">warinukraine.info@gmail.com</a>" в котором необходимо указать кто Вы и почему Вы хотите публиковать записи у нас.</p>'
})

Static.create!({
  url: 'thanks',
  title: 'Наши БОЛЬШИЕ благодарности :)',
  html: '<p>Пока нам некого благодарить :(</p><p>Но в скором времени здесь появиться много имен и ссылок (мы надеемся). Если Вы считаете, что как-то можете помочь проекту, пожалуйста, напишите нам вот сюда: "<a href="mailto:warinukraine@gmail.com">warinukraine.info@gmail.com</a>".</p>'
})

puts 'Static pages created..'
