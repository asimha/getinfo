class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.belongs_to :user, index: true
      t.belongs_to :group, index: true
      t.boolean :is_confirmed
      t.timestamps null: false
    end
  end
end
