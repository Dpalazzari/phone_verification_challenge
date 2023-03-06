class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def expired?
    DateTime.now > expiration
  end
end
