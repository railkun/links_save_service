class Link < ApplicationRecord
  belongs_to :user

  validates :link, presence: true

  acts_as_taggable_on :tags
end
