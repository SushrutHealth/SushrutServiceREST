class Video < ActiveRecord::Base

  has_many :mentions
  has_and_belongs_to_many :artists
  has_and_belongs_to_many :users

  validates_presence_of :url
  validates_presence_of :video_id
  validates_uniqueness_of :video_id
  validates_uniqueness_of :title

  validates :title, :length => { :maximum => 200 }

  include NamedScopes::DateTime
  include NamedScopes::Popularity

  scope :popular_from_artist, lambda { |artist, age|
    Video.joins{artists}.where{artists.id == artist.id}.popular_from_last(age)
  }
  scope :popular_from_source, lambda { |source, age|
    Video.joins{mentions.source}.where{mentions.source_id == source.id}.popular_from_last(age)
  }

  searchable do
    text    :title
    integer :popularity
    time    :created_at
  end


  def sources
    mentions.map(&:source).sort_by(&:popularity)
  end

  def self.primary_search(query)
    Video.solr_search do
      fulltext query
      order_by :created_at, :desc
      order_by :popularity, :desc
      paginate :per_page => 10
    end
  end

  def self.construct(mention, video)
    video = Video.find_or_create_by_url(
              :title => video.title,
              :url => video.url,
              :video_id => video.video_id,
              :provider => video.provider,
              :description => video.description,
              :keywords => video.keywords,
              :duration => video.duration,
              :date => video.date,
              :thumbnail_small => video.thumbnail_small,
              :thumbnail_large => video.thumbnail_large,
              :width => video.width,
              :height => video.height
            )
    mention.video_id = video.id
    mention.save
    BeanCounter.rank(video)
    video
  end
end
