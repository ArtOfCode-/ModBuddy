class User < ApplicationRecord
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.with_role_on_any(role, collection)
    User.joins(:roles).where(roles: { name: role.to_s, resource_type: collection.first.class.to_s, resource_id: collection.map(&:id) })
  end
end
