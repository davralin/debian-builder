#!/bin/bash
/bin/rm -rf /usr/local/git
OUTDIR="/usr/local/git/build"
/bin/mkdir -p $OUTDIR
/usr/bin/apt-get update

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

# This installs needed packages for building using apt-get builddep
if [ "$BUILDDEP" = "" ]
then
   echo "No builddep requested"
else
   echo "Installing build-dependencies using apt-get.."
   /usr/bin/apt-get build-dep -qq -y $BUILDDEP
fi

# This installs needed packages for building using apt-get install
if [ "$BUILDPKG" = "" ]
then
   echo "No buildpackages requested"
else
   echo "Installing build-requires using apt-get.."
   /usr/bin/apt-get install -qq -y $BUILDDEP
fi

cd $OUTDIR
/usr/bin/debuild --no-tgz-check -uc -us

