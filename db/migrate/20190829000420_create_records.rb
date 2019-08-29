class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.integer :type
      t.string :host
      t.integer :ttl
      t.string :content
      t.belongs_to :domain, foreign_key: true

      t.timestamps
    end
  end
end
