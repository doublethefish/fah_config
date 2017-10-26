for branch in `git for-each-ref --shell --format="%(refname)" refs/heads/ | sed 's|refs/heads/||g' | sed s/\'//g`; 
do 
  echo ""
  echo "==============================================================================="
  echo "Rebasing : '$branch'"
  echo "==============================================================================="
  git checkout $branch && git rebase master # || break; 

  ret=$?
  while [[ $ret -gt 0 ]]
  do
    echo ""
    echo "==============================================================================="
    echo "Rebasing : '$branch' completed with $ret"
    echo "==============================================================================="

    echo $1
    if [ "$1" = "skip" ]; then
      echo "aborting"
      git rebase --abort
      ret=0
    else
      echo "merging"
      git mergetool && git rebase --continue || git rebase --skip
      ret=$?
    fi

  done

done;

