class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## User information
      t.string :name,    :null => false, :default => ""
      t.index  :name,    :unique => true
      t.string :profile, :null => false, :default => ""

      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.index  :email,              :unique => true
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.index    :reset_password_token,   :unique => true
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Timeoutable
      t.integer  :timeout_in, :default => 30.minutes, :null => false

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.index    :confirmation_token,   :unique => true
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.index  :unlock_token,      :unique => true
      t.datetime :locked_at

      t.timestamps
    end

  end
end
