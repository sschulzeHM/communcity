namespace :export do
  desc "Prints DB enries in a seeds.rb way."
  task :seeds_format => :environment do
    Organisation.order(:id).all.each do |organisation|
      puts "Organisation.create(#{organisation.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
    User.order(:id).all.each do |user|
      puts "User.create(#{user.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
    Project.order(:id).all.each do |project|
        pString = "Project.create(#{project.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
        dateFrom = '"date_from"=>'
        dateTo = '"date_to"=>'
        score = '"score"=>'
        pString.insert( pString.index(dateFrom)+dateFrom.length, '"')
        pString.insert( pString.index(dateTo)-2, '"')
        pString.insert( pString.index(dateTo)+dateTo.length, '"')
        pString.insert( pString.index(score)-2, '"')
        puts pString
    end
  end
end