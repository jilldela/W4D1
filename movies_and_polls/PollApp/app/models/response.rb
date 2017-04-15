# == Schema Information
#
# Table name: responses
#
#  id         :integer          not null, primary key
#  answer_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Response < ApplicationRecord
  validate :already_answered
  validate :cant_respond_to_own_poll

  belongs_to :answer_choice,
    class_name: 'AnswerChoice',
    primary_key: :id,
    foreign_key: :answer_id

  belongs_to :respondent,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :user_id

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    question.responses
      .where.not(id: id)
  end

  def respondent_already_answered?
    sibling_responses.map(&:user_id).include?(user_id)
  end

  def already_answered
    if respondent_already_answered?
      errors[:base] << "The respondent has already answered."
      puts "The respondent has already answered."
    end
  end

  def author_wrote_poll?
    answer_choice.question.poll.author_id == user_id
  end

  def cant_respond_to_own_poll
    if author_wrote_poll?
      errors[:base] << "Author can't respond to own poll"
      puts "Author can't respond to own poll"
    end
  end
end
