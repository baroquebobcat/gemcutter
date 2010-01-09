source "http://gems.github.com"

gem "rails", :git => "git://github.com/rails/rails"
gem "arel",  :git => "git://github.com/rails/arel"
gem "rack",  :git => "git://github.com/rails/rack"

gem "aws-s3",           "0.6.2", :require_as => "aws/s3"
gem "clearance",        "0.8.2"
gem "ddollar-pacecar",  "1.1.6", :require_as => "pacecar"
gem "gchartrb",         "0.8",   :require_as => "google_chart"
gem "gravtastic",       "2.1.3"
gem "rack-maintenance", "0.3.0", :require_as => "rack/maintenance"
gem "rest-client",      "1.0.3", :require_as => "rest_client"
gem "sinatra",          "0.9.4"
gem "will_paginate",    "2.3.11"
gem "xml-simple",       "1.0.12"

only :test do
  gem "cucumber",     "0.3.101"
  gem "factory_girl", "1.2.3"
  gem "fakeweb",      "1.2.6"
  gem "nokogiri",     "1.4.1"
  gem "rack-test",    "0.5.0", :require_as => "rack/test"
  gem "redgreen",     "1.2.2"
  gem "rr",           "0.10.4"
  gem "shoulda",      "2.10.2"
  gem "treetop",      "1.4.3"
  gem "webrat",       "0.5.3"
  gem "webmock",      "0.7.3"
end

only [:staging, :production] do
  gem "ambethia-smtp-tls", "1.1.2", :require_as => "smtp-tls"
  gem "memcache-client",   "1.7.5", :require_as => "memcache"
  gem "rack-cache",        "0.5.2", :require_as => "rack/cache"
end
