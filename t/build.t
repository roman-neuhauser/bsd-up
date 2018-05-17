setup::

  $ . $TESTDIR/setup


test success::

  $ bsd-up -b
  o make -j8 buildworld
  o make -j8 buildkernel


test $KERNCONF use::

  $ bsd-up -b KERNCONF=fubar
  o make -j8 buildworld
  o make -j8 buildkernel

  $ KERNCONF=fubar bsd-up -b
  o make -j8 buildworld
  o make -j8 buildkernel KERNCONF=fubar
