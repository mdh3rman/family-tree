class Person < ApplicationRecord
  has_ancestry

  before_validation do
    self.ancestry = nil if self.ancestry.blank?
  end
end
