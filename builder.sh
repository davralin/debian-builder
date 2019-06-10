#!/bin/bash
/bin/rm -rf /usr/local/git
OUTDIR="/usr/local/git/build"
/bin/mkdir -p $OUTDIR

# This checks if a gitrepo was provided, and fails if not.
if [ "$GITREPO" = "" ]; then
   echo "You need to set GITREPO"
   exit 1
fi

# This checks out given gitrepo, on given branch or default.
if [ "$GITBRANCH" = "" ]
then
   echo "Checking out master.."
   /usr/bin/git clone -q $GITREPO $OUTDIR
else
   echo "Checking out $GITBRANCH.."
   /usr/bin/git clone -q --branch $GITBRANCH $GITREPO $OUTDIR
fi

# This installs needed packages for building
if [ "$BUILDDEP" = "" ]
then
   echo "No dependencies needed? You sure?"
else
   echo "Installing build-dependencies.."
   /usr/bin/apt-get install -qq -y $BUILDDEP
fi

cd $OUTDIR
/usr/bin/debuild --no-tgz-check -uc -us

