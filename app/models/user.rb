class User < ApplicationRecord
  belongs_to :company, optional: true, autosave: true
  ############################################################################################
  ## PeterGate Roles                                                                        ##
  ## The :user role is added by default and shouldn't be included in this list.             ##
  ## The :root_admin can access any page regardless of access settings. Use with caution!   ##
  ## The multiple option can be set to true if you need users to have multiple roles.       ##
  petergate(roles: [:admin, :editor], multiple: true)                                      ##
  ############################################################################################ 
  has_secure_password
  
  before_save { self.email = email.downcase! || self.email }
  
  # Verify that email field is not blank and that it doesn't already exist in the db (prevents duplicates):
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
