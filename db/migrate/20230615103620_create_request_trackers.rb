class CreateRequestTrackers < ActiveRecord::Migration[7.0]
  def change
    create_table :request_trackers do |t|
      t.datetime :datetime
    end
  end
end
