#!/bin/bash
#FLUX: --job-name=lovable-platanos-7275
#FLUX: -t=1800
#FLUX: --urgency=16

. /etc/bashrc
. /etc/profile.d/modules.sh
module load opencl-nvidia/10.0
./pagerank /var/scratch/alvarban/BSc_2k19/graphs/G500/graph500-23.e /var/scratch/alvarban/BSc_2k19/graphs/G500/graph500-23.v
