require 'net/ssh'

key_path_variants = [
  'C:\\Users\\DELL\\Downloads\\Ruby-assign.pem',          # double backslashes
  'C:/Users/DELL/Downloads/Ruby-assign.pem',              # forward slashes
  File.expand_path('~/Downloads/Ruby-assign.pem'),        # ~ expands to your user home
  'C:/Users/DELL/Downloads/Ruby-assign.pem'               # repeat for clarity
]

key_path_variants.each do |path|
  puts "Trying path: #{path}"
  
  if File.exist?(path) && File.file?(path)
    puts "  File exists (size: #{File.size(path)} bytes)."
  else
    puts "  File DOES NOT exist or is not a regular file!"
    next
  end

  begin
    # Attempt to start a dummy connection with only this key
    # (we'll force failure after key load attempt by using invalid host)
    Net::SSH.start('invalid-host-for-testing', 'dummy', {
      keys: [path],
      timeout: 3,
      verbose: :debug,               # this will print key loading details to console
      auth_methods: ['publickey']
    }) do |ssh|
      puts "  Connected (unexpected!)"
    end
  rescue Net::SSH::AuthenticationFailed => e
    puts "  Key was offered but authentication failed (expected on dummy host): #{e.message}"
    puts "  → This means Net::SSH successfully LOADED and TRIED the key!"
  rescue OpenSSL::PKey::PKeyError, ArgumentError, RuntimeError => e
    puts "  FAILED to load/parse key: #{e.class} - #{e.message}"
  rescue Errno::ECONNREFUSED, SocketError, Timeout::Error => e
    puts "  Connection attempt failed (normal for dummy host), but key load likely succeeded if no parse error above."
    puts "  → Check debug output for 'Offering public key' or 'could not load private key' lines."
  rescue => e
    puts "  Unexpected error: #{e.class} - #{e.message}"
    puts e.backtrace.first(5).join("\n  ")
  end
  puts "-----"
end