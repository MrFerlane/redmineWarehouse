class CreateMerchandises < ActiveRecord::Migration
  def change
    create_table :merchandises do |t|

      t.integer :issue_id

      t.string :name

      t.integer :value

      t.integer :count

      t.datetime :created_on


    end

  end
end
