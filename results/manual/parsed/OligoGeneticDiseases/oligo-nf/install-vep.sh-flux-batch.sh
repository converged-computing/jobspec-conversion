#!/bin/bash
#FLUX: --job-name=Singularity install VEP annotator
#FLUX: -t=7200
#FLUX: --urgency=16

module load any/singularity/3.7.3
module load squashfs/4.4
singularity exec vep.sif INSTALL.pl -c $HOME/vep_data -a c -s homo_sapiens -y GRCh37 -n --CACHE_VERSION 108
