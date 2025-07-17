#!/bin/bash
#FLUX: --job-name=bumfuzzled-blackbean-3377
#FLUX: -n=4
#FLUX: --queue=sched_mit_hill
#FLUX: -t=720
#FLUX: --urgency=16

module load jdk/18.0.1.1
module load singularity/3.7.0
curl -s https://get.nextflow.io | bash
mkdir -p ~/bin && mv nextflow ~/bin
PATH=~/bin:$PATH
SINGULARITY_CACHEDIR=~/.singularity
SINGULARITY_TMPDIR=/tmp
NXF_SINGULARITY_CACHEDIR=/home/${USER}/.singularity
