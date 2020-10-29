class CreateDomainCheckHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :domain_check_histories do |t|
      t.string :pattern
      t.string :extension
      t.string :starts_with
      t.string :omit
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
