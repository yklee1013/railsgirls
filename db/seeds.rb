# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Identity.create! name: 'admin', email: 'admin@admin.com',
                 password_digest: '$2a$10$gWmU5bzqU4NS.qGFmDuYIeaaCJWyp/1FKsGezCTqt23OEQV1AjQKm',
                 confirmed: true
User.create! name: 'admin', email: 'admin@admin.com'
