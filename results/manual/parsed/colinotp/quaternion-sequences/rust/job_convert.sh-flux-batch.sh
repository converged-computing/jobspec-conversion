#!/bin/bash
#FLUX: --job-name=goodbye-lizard-4954
#FLUX: -c=16
#FLUX: -t=1080000
#FLUX: --urgency=16

n=$1
start2=`date +%s`
./target/release/rust convert $n
end2=`date +%s`
echo Converting to matrices up to Hadamard equivalence took `expr $end2 - $start2` seconds.
