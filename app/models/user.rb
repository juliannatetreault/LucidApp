class User < ActiveRecord::Base
    has_many :journal_entries
    has_secure_password

    validates :username, :email, presence: true
end
