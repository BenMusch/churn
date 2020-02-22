require 'fileutils'

module TransactionCache
  class LocalFileCache
    def initialize(root_dir: Rails.root.join('cache'))
      FileUtils.mkdir_p(root_dir)
      @root_dir = root_dir
    end

    def get(account)
      if File.file?(cache_file_path(account))
        data = JSON.parse(File.read(cache_file_path(account)))
        data.map { |plaid_data| Transaction.load_from_plaid(plaid_data) }
      else
        nil
      end
    end

    # TODO: allow to set PORO and plaid hash
    def set(account, data)
      File.open(cache_file_path(account), "w") do |f|
        f.write(data.to_json)
      end
    end

    def del(account)
      nil
    end

    private

    attr_accessor :root_dir

    def cache_file_path(account)
      File.join(root_dir, "#{account.plaid_id}.json")
    end
  end
end
