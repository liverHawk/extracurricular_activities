class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :description
      t.string :website
      t.string :logo
      t.string :email
      t.string :campus
      t.boolean :is_internal, null: false, default: true
      t.integer :status, null: false, default: 0
      t.timestamps
    end

    add_index :organizations, :name, unique: true
    add_index :organizations, :email, unique: true
    add_index :organizations, :campus
    add_index :organizations, :is_internal
    add_index :organizations, :status
  end
end
