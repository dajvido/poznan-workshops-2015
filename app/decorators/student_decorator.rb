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

  def study_date(st_date)
    unless st_date.nil?
      st_date.strftime("%b %Y")
    else
      "-"
    end
  end

  def dollars
    "$%.2f" % debt
  end
end
