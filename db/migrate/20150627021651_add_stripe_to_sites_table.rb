class AddStripeToSitesTable < ActiveRecord::Migration
  def change
  	add_column :sites, :stripe_secret_key, :string
  	add_column :sites, :stripe_public_key, :string
  	add_column :sites, :stripe_live_mode,  :boolean
  end
end
