#!/bin/bash

dir=`dirname "$0"`

tmpdir=`mktemp -d`
pipe="$tmpdir/fifo"
mkfifo "$pipe"

cat - | "$dir"/aprs.py "$@" -p "$pipe" &

tpid=$!

function ex() {
  kill $tpid
  rm $pipe
  rmdir $tmpdir
}

trap ex SIGINT SIGTERM

#xterm -e "cat $pipe | aplay -r 24000 -" 
xterm -e "cat $pipe | direwolf -r 24000 -b 16 -t=0 -" 

#xterm -e "cat $pipe "

ex
