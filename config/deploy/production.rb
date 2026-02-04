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