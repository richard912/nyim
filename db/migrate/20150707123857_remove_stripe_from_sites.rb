class RemoveStripeFromSites < ActiveRecord::Migration
  def up
    remove_column :sites, :stripe_secret_key
    remove_column :sites, :stripe_public_key
    remove_column :sites, :stripe_live_mode
  end

  def down
    add_column :sites, :stripe_secret_key, :string
    add_column :sites, :stripe_public_key, :string
    add_column :sites, :stripe_live_mode,  :boolean
  end
end
