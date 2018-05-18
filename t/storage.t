setup::

  $ . $TESTDIR/setup

  $ fake -o id -u <<EOF
  > 69
  > EOF


test that failing mount aborts::

  $ fake -cx 42 sudo mount -t tmpfs

  $ bsd-up -m
  o cd /usr/src
  o sudo mount -t tmpfs -o uid=69,size=16g tmpfs /usr/obj
  [42]


test success::

  $ fake -c sudo mount -t tmpfs

  $ bsd-up -m
  o cd /usr/src
  o sudo mount -t tmpfs -o uid=69,size=16g tmpfs /usr/obj
  o sudo umount /usr/obj
