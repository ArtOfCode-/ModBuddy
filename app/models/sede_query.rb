class SEDEQuery < ApplicationRecord
  belongs_to :offense_type
  has_many :review_results
  resourcify

  def fetch
    check_directory_structure

    resp = HTTParty.get url
    if resp.code == 200
      File.open(File.join(Rails.root, "public/query_data/#{id}/latest.csv"), 'w:UTF-8') do |f|
        f.write(resp.body.encode('UTF-8', invalid: :replace, undef: :replace, replace: '?'))
      end
      true
    else
      false
    end
  end

  def load
    if File.exist? File.join(Rails.root, "public/query_data/#{id}/latest.csv")
      CSV.read File.join(Rails.root, "public/query_data/#{id}/latest.csv")
    else
      [['No data found']]
    end
  end

  private

  def check_directory_structure
    unless Dir.exist?(File.join(Rails.root, "public/query_data/#{id}"))
      FileUtils.mkdir_p(File.join(Rails.root, "public/query_data/#{id}"))
    end
  end
end
