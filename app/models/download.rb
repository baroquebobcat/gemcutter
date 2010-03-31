class Download
  COUNT_KEY     = "downloads"
  TODAY_KEY     = "downloads:today"
  YESTERDAY_KEY = "downloads:yesterday"

  def self.incr(version)
    $redis.incr(COUNT_KEY)
    $redis.incr(key(version.rubygem))
    $redis.incr(key(version))
    $redis.zincrby(TODAY_KEY, 1, version.full_name)
  end

  def self.count
    $redis[COUNT_KEY].to_i
  end

  def self.today(version)
    $redis.zscore(TODAY_KEY, version.full_name).to_i
  end

  def self.for(what)
    $redis[key(what)].to_i
  end

  def self.key(what)
    case what
    when Version
      "downloads:version:#{what.full_name}"
    when Rubygem
      "downloads:rubygem:#{what.name}"
    end
  end

  def self.history_key(what)
    case what
    when Version
      "downloads:version_history:#{what.full_name}"
    when Rubygem
      "downloads:rubygem_history:#{what.name}"
    end
  end

  def self.rollover
    $redis.rename TODAY_KEY, YESTERDAY_KEY

    yesterday = 1.day.ago.to_date.to_s
    versions  = Version.all(:include => :rubygem).inject({}) do |hash, v|
      hash[v.full_name] = v
      hash
    end

    downloads = Hash[*$redis.zrange(YESTERDAY_KEY, 0, -1, "withscores")]
    downloads.each do |key, score|
      version = versions[key]
      $redis.hincrby history_key(version), yesterday, score
      $redis.hincrby history_key(version.rubygem), yesterday, score
    end
  end
end
