class CreateLaboratoryCodeTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :laboratory_code_types do |t|

      t.timestamps
    end
  end
end
