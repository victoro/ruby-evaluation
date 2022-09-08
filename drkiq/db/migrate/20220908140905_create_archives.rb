class CreateArchives < ActiveRecord::Migration[7.0]
  def change
    create_table :archives do |t|

      t.timestamps
    end
  end
end
