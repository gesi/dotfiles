function repo
  set origin (git remote get-url origin)
  set url (string replace -r '^git@github.com:(.*)\.git' 'https://github.com/$1' $origin)

  # navigate to current branch  
  set branch (git rev-parse --abbrev-ref HEAD)
  set url $url/tree/$branch

  # navigate to current directory
  set repo_path (git rev-parse --show-toplevel)
  set relative_path (string replace $repo_path '' (pwd))
  if test $relative_path
    set url (string join $relative_path $url '')
  end

  open --url $url
end