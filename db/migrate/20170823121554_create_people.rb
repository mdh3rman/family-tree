class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :name
      t.date :dateOfBirth
      t.string :ancestry
      t.string :relationshipType


      t.timestamps
    end
  end
end
