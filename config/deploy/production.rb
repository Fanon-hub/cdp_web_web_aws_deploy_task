<<<<<<< Updated upstream
server '3.82.244.58',
  user: 'ec2-user',
  roles: %w{app db web},
  primary: true

set :ssh_options, {
  keys: ['C:/Users/DELL/Downloads/Ruby-assign.pem'],
  forward_agent: false,
  auth_methods: %w(publickey),
  verify_host_key: :never
} 
=======
# config/deploy/production.rb

# The server you're deploying to
server '3.82.244.58',
  user: 'ec2-user',
  roles: %w{app db web},          # all roles on one server (typical for single-instance EC2)
  primary: true                   # optional but good to mark as main

# SSH options – VERY important for AWS .pem keys
set :ssh_options, {
  keys: ['C:/Users/DELL/Downloads/Ruby-assign.pem'],  # full Windows path to your .pem file
  forward_agent: false,
  auth_methods: %w(publickey),                        # key-based auth only
  verify_host_key: :never                             # skips strict host key checking (common for first EC2 connects)
}
>>>>>>> Stashed changes
