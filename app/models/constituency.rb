class Constituency < ActiveRecord::Base
  #has_many :townships
  has_many :towns
  has_many :candidates
  has_many :events
  has_many :comments, :order => 'created_at DESC' # shoutbox in geo controller
  
  attr_accessor :user_count
  
  def self.all_with_count
    count = self.count()
    result = find(:all)
    result.each {|c| c.user_count = count[c]}
    return result
  end
  
  def self.count
    returning(Hash.new(0)) do |result|
      find_by_sql("select constituencies.*, count(DISTINCT users.id) as cnt from users,towns,constituencies where users.town_id = towns.id and towns.constituency_id = constituencies.id group by constituencies.id").each do |c|
        result[c] = c.cnt.to_i
      end
    end
  end

  def usercount # TODO: integrate this with user_count (horrible I know)
    self.class.count[self]
  end
  
  def url_friendly_name
    self.name.downcase.gsub(/ü/,'ue').gsub(/ö/,'oe').gsub(/ä/,'ae').gsub(/[^a-z]/,'-')
  end
  
  # 0..255
  def alpha(biggest)
    (50 + 150 * (@user_count.to_f / biggest)).to_i
  end
  
  def full_name
    "#{code} #{name}"
  end
end
