class StudentDecorator < BaseDecorator
  def full_name
    "#{first_name} #{last_name}"
  end

  def birthdate_formated
    birthdate.strftime("%Y-%m_%d") unless birthdate.nil?
  end

  def avg_notes(subject_item)
    notes = subject_item.subject_item_notes.where(student: student)
    sprintf('%.2f', notes.empty? ? 0 : notes.map(&:value).inject(:+).to_f / notes.count)
  end
end
