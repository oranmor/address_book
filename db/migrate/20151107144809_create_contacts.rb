class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.text :first_name, null: false
      t.text :last_name, null: false
      t.text :emails, array: true, default: []
      t.text :phones, array: true, default: []
      t.timestamps null: false
    end
  end
end
