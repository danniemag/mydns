class CreateDomains < ActiveRecord::Migration[5.2]
  def change
    create_table :domains do |t|
      t.string :name, null: false
      t.integer :main_domain

      t.timestamps
    end
  end
end
