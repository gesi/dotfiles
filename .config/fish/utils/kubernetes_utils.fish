function kc -d "List or switch contexts"
  if set -q $argv
    kubectl config get-contexts
  else
    kubectl config use-context $argv
  end
end