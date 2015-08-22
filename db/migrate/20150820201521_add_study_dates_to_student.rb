class AddStudyDatesToStudent < ActiveRecord::Migration
  def change
    add_column :students, :start_date, :date
    add_column :students, :end_date, :date
  end
end
