class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :title, limit: 127
      t.text :description

      t.timestamps
    end
  end
end
