begin db_pass = IO.read(ENV['DB_PASS_FILE']).chomp rescue "" end

AppConfig[:db_url] = "jdbc:mysql://#{ENV['DB_HOST']}:#{ENV['DB_PORT']}/#{ENV['DB_NAME']}?user=#{ENV['DB_USER']}&password=#{db_pass}&useUnicode=true&characterEncoding=UTF-8"
AppConfig[:public_url] = 'http://localhost:8081'
AppConfig[:public_proxy_url] = "https://#{ENV['PUI_HOST']}"

## Plug-ins to load. They will load in the order specified
AppConfig[:plugins] = ['local',
                       'lcnaf'
]

# Add additional config options/overrides as necessary