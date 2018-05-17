setup::

  $ . $TESTDIR/setup


test success::

  $ bsd-up -i
  o cd /usr/src
  o sudo mergemaster -Fp
  o sudo make installkernel
  o sudo make installworld
  o sudo mergemaster -Fi


test $KERNCONF use::

  $ bsd-up -i KERNCONF=fubar
  o cd /usr/src
  o sudo mergemaster -Fp
  o sudo make installkernel
  o sudo make installworld
  o sudo mergemaster -Fi

  $ KERNCONF=fubar bsd-up -i
  o cd /usr/src
  o sudo mergemaster -Fp
  o sudo make installkernel KERNCONF=fubar
  o sudo make installworld
  o sudo mergemaster -Fi
