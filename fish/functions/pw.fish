function pw --description "copy password from 1password to pasteboard"
  if not string length --quiet $argv
    echo "You need to provide an item name or id"
  else 
    op item get --fields password $argv | pbcopy
  end
end

