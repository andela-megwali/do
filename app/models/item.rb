class Item < ActiveRecord::Base
  extend Paginate

  belongs_to :bucketlist

  validates_presence_of :name, :bucketlist_id

  before_create :status

  private

  def status
    self.done ||= 0
  end
end
