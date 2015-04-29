class SplitFullNameIntoFirstNameAndLastName < ActiveRecord::Migration
  def change
    users = User.all.map { |user| [user.id, user.name]}
    remove_column :users, :name
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    users.each do |user|
      u = User.find(user[0])
      unless user[1].nil?
        u.first_name = user[1].split(" ")[0]
        u.last_name = user[1].split(" ")[1]
        u.save!
      end
    end
  end
end
