class AddStudentIdToSubjectItemNote < ActiveRecord::Migration
  def change
    change_table :subject_item_notes do |t|
      t.belongs_to :student
    end
  end
end
