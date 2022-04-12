class CreateRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :records do |t|
      t.date :fromDate
      t.date :toDate

      t.timestamps
    end
  end
end
