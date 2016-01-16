module BeanCounter

  def self.rank(objects)
    [objects].flatten.in_groups_of(2, false).each do |object_group|
      object_group.flatten.each do |object|
        if object.respond_to?(:url)
          object.update_attribute(:popularity, popularity(object.url))
        end
      end
      sleep 2.seconds
    end
  end

  def self.popularity(url)
    counts = ShareCounts.selected(url, [:twitter, :facebook])
    counts[:twitter].to_i + counts[:facebook].to_i
  end
end