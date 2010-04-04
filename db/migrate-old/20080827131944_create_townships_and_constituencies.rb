class CreateTownshipsAndConstituencies < ActiveRecord::Migration
  def self.up
    create_table 'townships' do |t|
      t.string :code
      t.string :name
      t.integer :constituency_id
    end
    
    create_table 'constituencies' do |t|
      t.string :code
      t.string :name
    end
    
    # Fill data
    %w(townships constituencies).each do |t|
      lines = File.readlines(File.dirname(__FILE__)+"/../data/#{t}.sql").map {|l| l.chomp}
      lines.each {|l| execute(l) }
    end
  end

  def self.down
    drop_table 'townships'
    drop_table 'constituencies'
  end
end
