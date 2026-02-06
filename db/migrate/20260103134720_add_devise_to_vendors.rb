# frozen_string_literal: true

class AddDeviseToVendors < ActiveRecord::Migration[7.0]
  def self.up
    add_index :vendors, :email,                unique: true
    add_index :vendors, :reset_password_token, unique: true
  end
end
