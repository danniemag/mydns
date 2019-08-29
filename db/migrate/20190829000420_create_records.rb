class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.integer :type, null: false
      t.string :host, null: false
      t.integer :ttl
      t.string :content, null: false
      t.belongs_to :domain, foreign_key: true

      t.timestamps
    end
  end
end
