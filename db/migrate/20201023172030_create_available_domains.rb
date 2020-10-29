class CreateAvailableDomains < ActiveRecord::Migration[5.1]
  def change
    create_table :available_domains do |t|
      t.references :domain_check_history
      t.string :name

      t.timestamps
    end
  end
end
