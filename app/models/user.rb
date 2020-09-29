class User < ApplicationRecord
    has_many :posts

    has_secure_password

    validates :username, presence: true, uniqueness: {case_sensitive: false}
    validates :first_name, :last_name, presence: true
end
