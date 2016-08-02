#!/bin/bash

dir=`dirname "$0"`

tmpdir=`mktemp -d`
pipe="$tmpdir/fifo"
mkfifo "$pipe"

cat - | "$dir"/dsd.py "$@" -p "$pipe" &

tpid=$!

function ex() {
  kill $tpid
  rm $pipe
  rmdir $tmpdir
}

trap ex SIGINT SIGTERM

#xterm -e "cat $pipe | aplay -r 24000 -" 
xterm -e "cat $pipe | dsd -u 10 -i - -w dsd_output.wav" 

#xterm -e "cat $pipe "

ex
