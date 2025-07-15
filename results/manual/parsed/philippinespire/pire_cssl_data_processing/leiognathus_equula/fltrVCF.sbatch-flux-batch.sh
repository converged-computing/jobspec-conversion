#!/bin/bash
#FLUX: --job-name=fltrVCF
#FLUX: --priority=16

export SINGULARITY_BIND='/home/e1garcia'
export PARALLEL_SHELL='/bin/bash'

enable_lmod
module load container_env ddocent/2.7.8
export SINGULARITY_BIND=/home/e1garcia
export PARALLEL_SHELL=/bin/bash
bash /home/e1garcia/shotgun_PIRE/pire_cssl_data_processing/leiognathus_equula/fltrVCF.bash -s $1
