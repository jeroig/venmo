# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
juan   = User.create(email: 'juan@rootstrap.com',   nick: 'juan', balance: 500)
jose   = User.create(email: 'jose@rootstrap.com',   nick: 'jose', balance: 400)
pablo  = User.create(email: 'pablo@rootstrap.com',  nick: 'pablo', balance: 300)
ulises = User.create(email: 'ulises@rootstrap.com', nick: 'ulises', balance: 200)
raul   = User.create(email: 'raul@rootstrap.com',   nick: 'raul', balance: 100)

# Friendship
Friendship.create(user: juan, friend_id: jose)
Friendship.create(user: juan, friend_id: pablo)
Friendship.create(user: jose, friend_id: pablo)
Friendship.create(user: pablo, friend_id: ulises)
Friendship.create(user: ulises, friend_id: raul)

# Between each payment created we add a random sleep time
# in order to avoid same created time
Payment.create(sender: juan, receiver: jose, amount: 50, description: 'for shoes')
sleep(rand(1..3))
Payment.create(sender: juan, receiver: jose, amount: 300)
sleep(rand(1..3))
Payment.create(sender: juan, receiver: jose, amount: 500, description: 'for house rental')
sleep(rand(1..3))
Payment.create(sender: jose, receiver: pablo, amount: 60, description: 'for food')
sleep(rand(1..3))
Payment.create(sender: pablo, receiver: ulises, amount: 100, description: 'taxs')
sleep(rand(1..3))
Payment.create(sender: jose, receiver: juan, amount: 40, description: 'back from purchase')
sleep(rand(1..3))
Payment.create(sender: jose, receiver: pablo, amount: 150, description: 'school')
sleep(rand(1..3))
Payment.create(sender: pablo, receiver: ulises, amount: 20, description: 'more food')
sleep(rand(1..3))
Payment.create(sender: jose, receiver: juan, amount: 15)
sleep(rand(1..3))
Payment.create(sender: juan, receiver: jose, amount: 70)
