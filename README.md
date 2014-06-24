WarInUkraine
============


Установка
=========
1. [Установить RVM](https://rvm.io/rvm/install) и [Ruby 2.1](https://rvm.io/rubies/installing)
2. Создать пользователя "warinukraine" и базу данных "warinukraine_development" для PostgreSQL
3. Выполнить "bundle install"
4. Выполнить "rake db:migrate && rake db:seed"
5. Выполнить "rails s"
6. Готово! Рабочий сайт у вас будет по адресу: [http://localhost:3000/](http://localhost:3000/)


Планы на будущее
================

- [ ] Добавление блокпостов на карту ([необходимо обсуждение](https://github.com/WarInUkraine/WarInUkraine/issues/1))
- [ ] Выделение контроллируемых территорий на карте цветами, зонами ([необходимо обсуждение](https://github.com/WarInUkraine/WarInUkraine/issues/2))

Будем благодарны за помощь в реализации этих планов ;)

*Обновлено: 24 июня 2014 г.*