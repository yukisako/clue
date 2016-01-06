class CreateAbsenceTriggers < ActiveRecord::Migration
  def change
    create_table :absence_triggers do |t|
    t.boolean :classroom
    t.boolean :harm
    t.boolean :antipathy
    t.boolean :teacher
    t.boolean :friendship
    t.boolean :study
    t.boolean :change_school
    t.boolean :neglect
    t.boolean :dv
    t.boolean :poverty
    t.boolean :parents
    t.boolean :no_reason

      t.timestamps null: false
    end
  end
end
