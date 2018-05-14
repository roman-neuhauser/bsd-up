#!/usr/local/bin/zsh -f
# vim: sw=2 sts=2 et fdm=marker cms=\ #\ %s

# $0 fetch build install

setopt no_rcs
setopt c_bases
setopt octal_zeroes
setopt extended_glob
setopt null_glob
setopt hist_subst_pattern
setopt pipe_fail
setopt err_return
setopt no_unset
setopt warn_create_global

declare -gr objdir=/usr/obj
declare -gr srcdir=/usr/src

declare -ar steps=(
  u:update
  m:mkstorage
  b:build
  i:install
  d:delete-old
)

function help # {{{
{
  printf -->&2 "%4s     %s\n" \
    -b "build{world,kernel} KERNCONF" \
    -d "delete-old" \
    -i "install{kernel,world} + mergemaster KERNCONF" \
    -h "display this list" \
    -m "mdconfig + newfs + mount" \
    -u "git fetch etc"
  exit $1
} # }}}

function o # {{{
{
  print -ru 2 -- $0 "${(q-)@}"
  "$@"
} # }}}

function update # {{{
{
  ; local old new REPLY
  o git checkout master
  ; git rev-parse HEAD | read old
  o git fetch up
  o git merge --ff-only up
  ; git rev-parse HEAD | read new
  o git diff $old..$new -- UPDATING
  ; read -q "?continue? "
} # }}}

function cleanup # {{{
{
  o sudo umount $objdir
  o sudo mdconfig -d -u $1
} # }}}

function mkstorage # {{{
{
  ; local md
  o sudo mdconfig -at swap -s 16g | read md
  ; eval "function zshexit { cleanup $md; }"
  o sudo newfs -U /dev/$md
  o sudo mount /dev/$md $objdir
  o sudo chown $USERNAME $objdir
} # }}}

function build # {{{
{
  o make -j8 buildworld
  o make -j8 buildkernel \
    ${KERNCONF+"KERNCONF=$KERNCONF"}
} # }}}

function install # {{{
{
  o sudo mergemaster -Fp

  o sudo make installkernel \
    ${KERNCONF+"KERNCONF=$KERNCONF"}
  o sudo make installworld

  o sudo mergemaster -Fi
} # }}}

function delete-old # {{{
{
  o sudo make delete-old \
    -DBATCH_DELETE_OLD_FILES
} # }}}

declare -A requested

while getopts humbid opt; do
  case $opt in
  h) help 0 ;;
  ${(~j:|:)steps/:*})
    requested[${steps[(r)$opt:*]/$opt:}]=yo
  ;;
  esac
done; shift $((OPTIND - 1))

(( $#requested )) || help 1

cd $srcdir

for step in ${steps/*:}; do
  (( $+requested[$step] )) || continue
  $step
done
