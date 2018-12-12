class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :tweet
  field :text, type: String
end
