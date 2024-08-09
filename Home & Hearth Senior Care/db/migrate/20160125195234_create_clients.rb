class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.integer :client_id
      t.string :firstname
      t.string :lastname
      t.string :address1
      t.string :address2
      t.string :city
      t.string :zip
      t.string :state
      t.string :phone
      t.integer :plan_id
      t.datetime :startdate
      t.datetime :updated

      t.timestamps null: false
    end
    add_index :clients, :client_id, unique: true
  end
end
