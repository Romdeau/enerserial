# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean          default(FALSE)
#  role                   :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :stock_audit
  has_many :job

  USER_ROLES = %w[End\ User Sales Accounts Projects Purchasing Factory Managment]

  def admin?
    admin
  end

  def can_order?
    if role == "Purchasing" or admin
      true
    else
      false
    end
  end

  def can_account?
    if role == "Accounts" or admin
      true
    else
      false
    end
  end

  def can_project?
    if role == "Projects" or admin
      true
    else
      false
    end
  end

  def can_factory?
    if role == "Factory" or admin
      true
    else
      false
    end
  end

  def can_sales?
    if role == "Sales" or admin
      true
    else
      false
    end
  end

  def can_manage?
    if role == "Management" or admin
      true
    else
      false
    end
  end
end
