# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.create(user_name: "john")
user2 = User.create(user_name: "eric")
user3 = User.create(user_name: "gary")
user4 = User.create(user_name: "david")
user5 = User.create(user_name: "miles")

poll1 = Poll.create(title: "poll1", author_id: user1.id)
poll2 = Poll.create(title: "poll2", author_id: user1.id)
poll3 = Poll.create(title: "poll3", author_id: user1.id)
poll4 = Poll.create(title: "poll4", author_id: user2.id)
poll5 = Poll.create(title: "poll5", author_id: user3.id)

question1 = Question.create(text: "question1", poll_id: poll1.id)
question2 = Question.create(text: "question2", poll_id: poll1.id)
question3 = Question.create(text: "question3", poll_id: poll2.id)
question4 = Question.create(text: "question4", poll_id: poll3.id)
question5 = Question.create(text: "question5", poll_id: poll4.id)
question6 = Question.create(text: "question6", poll_id: poll5.id)

answer1 = AnswerChoice.create(text: "answer1", question_id: question1.id)
answer2 = AnswerChoice.create(text: "answer2", question_id: question1.id)
answer3 = AnswerChoice.create(text: "answer3", question_id: question2.id)
answer4 = AnswerChoice.create(text: "answer4", question_id: question2.id)
answer5 = AnswerChoice.create(text: "answer5", question_id: question2.id)
answer6 = AnswerChoice.create(text: "answer6", question_id: question3.id)
answer7 = AnswerChoice.create(text: "answer7", question_id: question4.id)


response1 = Response.create(answer_id: answer1.id, user_id: user1.id)
response2 = Response.create(answer_id: answer2.id, user_id: user1.id)
response3 = Response.create(answer_id: answer3.id, user_id: user1.id)
response4 = Response.create(answer_id: answer4.id, user_id: user1.id)
response5 = Response.create(answer_id: answer5.id, user_id: user1.id)
response6 = Response.create(answer_id: answer6.id, user_id: user1.id)
response7 = Response.create(answer_id: answer1.id, user_id: user2.id)
response8 = Response.create(answer_id: answer1.id, user_id: user1.id)
response9 = Response.create(answer_id: answer1.id, user_id: user1.id)
response10 = Response.create(answer_id: answer1.id, user_id: user4.id)
response11 = Response.create(answer_id: answer2.id, user_id: user5.id)
