class StudentDecorator < BaseDecorator
  def full_name
    "#{first_name} #{last_name}"
  end

  def avg_notes(subject_item)
    notes = subject_item.subject_item_notes
    sprintf('%.2f', notes.empty? ? 0 : notes.map(&:value).inject(:+).to_f / notes.count)
  end
end
