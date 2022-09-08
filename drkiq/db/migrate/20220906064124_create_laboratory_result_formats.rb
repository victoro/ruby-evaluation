class CreateLaboratoryResultFormats < ActiveRecord::Migration[7.0]
  def change
    create_table :laboratory_result_formats do |t|

      t.timestamps
    end
  end
end
