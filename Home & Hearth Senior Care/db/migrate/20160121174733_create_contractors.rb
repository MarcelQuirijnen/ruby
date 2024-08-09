class CreateContractors < ActiveRecord::Migration
  def change
    create_table :contractors do |t|
      t.integer :cont_id
      t.string :firstname
      t.string :lastname
      t.string :address1
      t.string :address2
      t.string :city
      t.string :zip
      t.string :state
      t.string :phone
      t.string :email
      t.datetime :startdate
      t.datetime :updated

      t.timestamps null: false
    end
    add_index :contractors, :cont_id, unique: true
  end
end
