class Question < ActiveRecord::Base
  include Bootsy::Container

  validates_presence_of :question
  validates_presence_of :answer

  def is_correct?(submission)
    answer = remove_white_space(self.answer.downcase)
    submission = remove_white_space(submission.downcase)
    
    # Will only do if the variables are numeric

    answer = convert_to_word(answer.to_i) if numeric?(answer)
    submission = convert_to_word(submission.to_i) if numeric?(submission)

    answer == submission
  end

  # Helper Methods
  
  def numeric?(string)
    !!(string.to_s =~ /\A[+-]?\d+\Z/)
  end
  
  # I've used number_and_words gem for this

  def convert_to_word(params)
    params.to_words
  end

  def remove_white_space(string)
    string.gsub(/\s+/, "")
  end

  
end
