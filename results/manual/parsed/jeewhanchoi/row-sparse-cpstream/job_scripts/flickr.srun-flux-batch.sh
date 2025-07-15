#!/bin/bash
#FLUX: --job-name=cc
#FLUX: -c=56
#FLUX: --queue=fat
#FLUX: -t=43200
#FLUX: --urgency=16

export KMP_AFFINITY='granularity=fine,compact,1'
export OMP_NUM_THREADS='56'

export KMP_AFFINITY=granularity=fine,compact,1
export OMP_NUM_THREADS=56
./build/Linux-x86_64/bin/splatt cpd -v --stream=4 -r 10 -t 56 --reg=frob,1e-2,4 ../hpctensor/flickr-4d.tns
