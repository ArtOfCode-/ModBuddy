class SEDEQuery < ApplicationRecord
  belongs_to :offense_type

  def fetch
    check_directory_structure

    resp = HTTParty.get url
    if resp.code == 200
      File.write(File.join(Rails.root, "public/query_data/#{id}/latest.csv"), resp.body)
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
