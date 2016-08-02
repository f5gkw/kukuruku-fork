#!/bin/bash

dir=`dirname "$0"`

tmpdir=`mktemp -d`
pipe="$tmpdir/fifo"
mkfifo "$pipe"

cat - | "$dir"/multimon.py "$@" -p "$pipe" &

tpid=$!

function ex() {
  kill $tpid
  rm $pipe
  rmdir $tmpdir
}

trap ex SIGINT SIGTERM

#xterm -e "cat $pipe | aplay -r 24000 -" 
xterm -e "cat $pipe | sox -t raw -esigned-integer -b 16 -r 24000 - -esigned-integer -b 16 -r 22050 -t raw - | multimon-ng -t raw \
-a SCOPE \
-a POCSAG512 \
-a POCSAG1200 \
-a POCSAG2400 \
-a FLEX \
-a EAS \
-a FMSFSK \
-a AFSK1200 \
-a AFSK2400 \
-a AFSK2400_2 \
-a AFSK2400_3 \
-a HAPN4800 \
-a FSK9600 \
-a DTMF \
-a ZVEI1 \
-a ZVEI2 \
-a ZVEI3 \
-a DZVEI \
-a PZVEI \
-a EEA \
-a EIA \
-a CCIR \
-a MORSE_CW \
-v3  -
"



#xterm -e "cat $pipe "

ex
