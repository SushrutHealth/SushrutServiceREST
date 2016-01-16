class Mention < ActiveRecord::Base

  belongs_to :source
  belongs_to :track
  belongs_to :album
  belongs_to :video

  validates_presence_of :title
  validates_presence_of :url
  validates_uniqueness_of :url

  include NamedScopes::DateTime


  def self.construct(source, entry)
    if mention = Mention.find_by_url(entry.url)
      mention
    else
      mention = Mention.new(
                  :title => entry.title,
                  :text => entry.andand.content,
                  :url => entry.url,
                  :date => entry.published,
                  :source_id => source.id
                )

      mention.save
      mention
    end
  end

  def artists
    video ? video.artists : []
  end
end
