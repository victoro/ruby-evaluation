class CreateExportCsvs < ActiveRecord::Migration[7.0]
  def change
    create_table :export_csvs do |t|

      t.timestamps
    end
  end
end
