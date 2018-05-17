setup::

  $ . $TESTDIR/setup


test that no output from mdconfig aborts::

  $ fbsd-up -m
  o sudo mdconfig -at swap -s 16g
  [1]


test that failing mdconfig aborts::

  $ fake -cb sudo mdconfig -at <<EOF
  > #!/bin/sh
  > echo md69
  > exit 42
  > EOF

  $ fbsd-up -m
  o sudo mdconfig -at swap -s 16g
  [42]


test success::

  $ fake -co sudo mdconfig -at <<EOF
  > md69
  > EOF

  $ fbsd-up -m
  o sudo mdconfig -at swap -s 16g
  o sudo newfs -U /dev/md69
  o sudo mount /dev/md69 /usr/obj
  o sudo chown roman /usr/obj
  o sudo umount /usr/obj
  o sudo mdconfig -d -u md69
