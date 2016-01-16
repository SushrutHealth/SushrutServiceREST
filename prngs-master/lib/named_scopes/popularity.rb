module NamedScopes::Popularity

  def self.included(base)
    base.class_eval do
      scope :by_popularity_desc, lambda { order{popularity.desc} }
      scope :popular_from_last, lambda { |age| from_last(age).by_popularity_desc }
      scope :top, lambda { |count| by_popularity_desc.limit(count) }
    end
  end
end