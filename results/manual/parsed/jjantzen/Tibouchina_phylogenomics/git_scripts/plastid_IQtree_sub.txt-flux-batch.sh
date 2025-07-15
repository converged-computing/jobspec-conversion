#!/bin/bash
#FLUX: --job-name=iqtree
#FLUX: -c=5
#FLUX: -t=360000
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
date
hostname
module purge
module load cuda/9.2.88 intel/2018.1.163 openmpi/3.1.2 iq-tree/1.6.10
iqtree -s plastid_whole_read_mapped_reduced.fasta -nt $SLURM_CPUS_ON_NODE -seed $RANDOM -m TEST -merit AIC -bb 1000
