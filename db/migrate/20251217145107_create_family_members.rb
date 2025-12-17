class CreateFamilyMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :family_members do |t|
      t.string :name
      t.string :status
      t.text :allergy_info
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
