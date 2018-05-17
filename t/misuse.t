setup::

  $ . $TESTDIR/setup


test that -h brings up usage::

  $ bsd-up -h
    -b     build{world,kernel} KERNCONF
    -d     delete-old
    -i     install{kernel,world} + mergemaster KERNCONF
    -h     display this list
    -m     mdconfig + newfs + mount
    -u     git fetch etc


test that no options brings up usage, fails::

  $ bsd-up
    -b     build{world,kernel} KERNCONF
    -d     delete-old
    -i     install{kernel,world} + mergemaster KERNCONF
    -h     display this list
    -m     mdconfig + newfs + mount
    -u     git fetch etc
  [1]


test that unknown option brings up usage, fails::

  $ bsd-up -x
  */bsd-up:*: bad option: -x (glob)
    -b     build{world,kernel} KERNCONF
    -d     delete-old
    -i     install{kernel,world} + mergemaster KERNCONF
    -h     display this list
    -m     mdconfig + newfs + mount
    -u     git fetch etc
  [1]
