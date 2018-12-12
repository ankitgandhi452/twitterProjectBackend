class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search

  embeds_many :comments, after_add: :increase_comment_count, after_remove: :decrease_comment_count, cascade_callbacks: true
  belongs_to :user

  field :text, type: String, default: "Sample tweet text."
  field :retweet, type: Boolean, default: false
  field :comments_count, type: Integer, default: 0

  search_in :text

  def increase_comment_count(comment)
    self.comments_count = self.comments_count + 1
    self.save!
  end

  def decrease_comment_count(comment)
    self.comments_count = self.comments_count - 1
    self.save!
  end
end
