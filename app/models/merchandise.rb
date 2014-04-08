class Merchandise < ActiveRecord::Base
  unloadable
  self.table_name = "merchandises"

  belongs_to :issue
  validates_presence_of :name
  validates_uniqueness_of :name

  scope :like, lambda { |q|
    q = q.to_s
    if q.blank?
      where({})
    else
      pattern = "%#{q}%"
      sql = %w(name).map { |column| "LOWER(#{table_name}.#{column}) LIKE LOWER(:p)" }.join(" OR ")
      params = {:p => pattern}
      where(sql, params)
    end
  }
end
