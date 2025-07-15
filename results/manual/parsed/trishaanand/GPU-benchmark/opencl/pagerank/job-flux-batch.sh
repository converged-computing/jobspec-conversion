#!/bin/bash
#FLUX: --job-name=crunchy-latke-9683
#FLUX: -t=1800
#FLUX: --priority=16

. /etc/bashrc
. /etc/profile.d/modules.sh
module load opencl-nvidia/10.0
./pagerank /var/scratch/alvarban/BSc_2k19/graphs/G500/graph500-23.e /var/scratch/alvarban/BSc_2k19/graphs/G500/graph500-23.v
