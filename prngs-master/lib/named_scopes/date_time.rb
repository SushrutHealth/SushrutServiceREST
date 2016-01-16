module NamedScopes::DateTime

  def self.included(base)
    base.class_eval do
      scope :from_last, lambda { |age| where{created_at >= age.ago} }
    end
  end
end