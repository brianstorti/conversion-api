class CreateConversions < ActiveRecord::Migration
  def change
    create_table :conversions do |t|
      t.integer :metric_id, index: true
      t.integer :start_date, index: true
      t.integer :time_range_length, index: true
      t.integer :end_date, index: true
      t.decimal :value
      t.integer :last_calculated_at
    end
  end
end
