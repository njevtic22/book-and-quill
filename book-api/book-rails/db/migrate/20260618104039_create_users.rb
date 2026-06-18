class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :surname, null: false
      t.string :email, null: false
      t.string :username, null: false
      t.string :password, null: false
      t.string :role, null: false

      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :users, :email, unique: true

    add_check_constraint(
      :users,
      "role IN ('admin', 'manager')",
      name: "users_role_check"
    )
  end
end
