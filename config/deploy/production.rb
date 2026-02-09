server '3.82.244.58',
       user: 'ec2-user',
       roles: %w{app db web},
       ssh_options: {
         keys: ['C:/Users/DELL/Downloads/Ruby-assign.pem'],
         auth_methods: %w(publickey),
         forward_agent: false
       }
