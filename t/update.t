setup::

  $ . $TESTDIR/setup

test that no output from mdconfig aborts::

  $ bsd-up -u
  o git checkout master
  [1]


test that no output from mdconfig aborts::

  $ cat > grp.values <<EOF
  > c001babe
  > deadbeef
  > EOF

  $ fake -b git rev-parse HEAD <<EOF
  > #!/bin/sh
  > head -1 $PWD/grp.values
  > sed -i -e 1d $PWD/grp.values
  > EOF

  $ echo y | bsd-up -u
  o git checkout master
  o git fetch up
  o git merge --ff-only up
  o git diff c001babe..deadbeef -- UPDATING
