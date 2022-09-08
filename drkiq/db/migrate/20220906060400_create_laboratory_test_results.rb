class CreateLaboratoryTestResults < ActiveRecord::Migration[7.0]
  def change
    create_table :laboratory_test_results do |t|

      t.timestamps
    end
  end
end
