#!/bin/sh
#
# git-svn-diff -- SVN-compatible diff against the tip of the tracking branch
#
# ChangeLog
#
#	Originally by http://mojodna.net/2009/02/24/my-work-git-workflow.html
#
#	<mike@mikepearce.net>
#	- <unknown changes>
#
#	aconway@[redacted]
#	- handle diffs that introduce new files
#
#	<jari.aalto@cante.net>
#	- Use readable POSIX $() instead backticsk
#	- Add ChangeLog
#	- Convert from bash to plain /bin/sh
#	- Fit as much as possible in 80 columns
#	- Make sed \/ quoting more readable using alternative separators
#	- Remove EOL whitespaces.

# Get the tracking branch (if we're on a branch)

TRACKING_BRANCH=$(git svn info | grep URL | sed -e 's,.*/branches/,,')

# If the tracking branch has 'URL' at the beginning, then the sed
# wasn't successful and we'll fall back to the svn-remote config
# option

case "$TRACKING_BRANCH" in
    URL*)
        TRACKING_BRANCH=$(git config --get svn-remote.svn.fetch |
                          sed -e 's,.*:refs/remotes/,,')
        ;;
esac

# Get the highest revision number

REV=$(git svn info |
      grep 'Last Changed Rev:' |
      sed -r 's/^.*: ([[:digit:]]*)/\1/')

# Then do the diff from the highest revision on the current branch and
# masssage into SVN format

git diff \
    --no-prefix $(git rev-list --date-order --max-count=1 $TRACKING_BRANCH) \
    "$@" |
sed -e "/--- \/dev\/null/{ N; s|^--- /dev/null\n+++ \(.*\)|---\1(revision 0)\n+++\1(revision 0)|;}" \
    -e "s/^--- .*/&     (revision $REV)/" \
    -e "s/^+++ .*/&     (working copy)/" \
    -e "s/^diff --git [^[:space:]]*/Index:/" \
    -e "s/^index.*/===================================================================/"

# End of file
