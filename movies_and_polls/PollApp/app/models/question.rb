# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :text
#  poll_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ApplicationRecord
  validates :text, presence: true

  has_many :answer_choices,
    class_name: 'AnswerChoice',
    primary_key: :id,
    foreign_key: :question_id

  belongs_to :poll,
    class_name: 'Poll',
    primary_key: :id,
    foreign_key: :poll_id

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results_n_1
    result = Hash.new(0)
    answer_texts = responses.map(&:answer_choice).map(&:text)
    answer_texts.each do |answer_text|
      result[answer_text] += 1
    end
    result
  end

  def sql_result
    answer_text = (<<-SQL, id
     SELECT answer_choices.*, COUNT(*) AS responses_count
     FROM answer_choices
     JOIN responses
     ON answer_choices.id = responses.answer_id
     WHERE answer_choices.question_id = ?
     GROUP BY answer_choices.id
    SQL
    )

    result = {}
    answer_text.each do |answer|
      result[answer.text] = answer.responses_count
    end
    result

  end

  def better_result
    answer_text = self
      .answer_choices
      .select("answer_choices.*, COUNT(*) AS responses_count")
      .joins(:responses)
      .group("answer_choices.id")

    result = {}
    answer_text.each do |answer|
      result[answer.text] = answer.responses_count
    end
    result
  end
end
