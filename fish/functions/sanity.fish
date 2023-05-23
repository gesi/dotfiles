function get_sanity_token
  npx sanity login $argv[1..-1]
  npx sanity debug --secrets | grep 'Auth token:' | awk -F"'" '{print $2}'
end

