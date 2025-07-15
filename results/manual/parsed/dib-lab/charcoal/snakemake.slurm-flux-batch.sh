#!/bin/bash
#FLUX: --job-name=red-hope-2779
#FLUX: --urgency=16

. ~/miniconda3/etc/profile.d/conda.sh
conda activate charcoal
set -o nounset
set -o errexit
set -x
cd ~/charcoal
python -m charcoal run conf/ibd2.conf -j 32 -k -p --unlock
python -m charcoal run conf/gtdb-contam-dna.conf -j 32 -k -p --unlock
python -m charcoal run conf/tara-delmont.conf -j 32 -k -p --unlock
python -m charcoal run conf/ibd2.conf -j 32 -k -p
python -m charcoal run conf/gtdb-contam-dna.conf -j 32 -k -p
python -m charcoal run conf/tara-delmont.conf -j 32 -k -p
env | grep SLURM            # Print out values of the current jobs SLURM environment variables
scontrol show job ${SLURM_JOB_ID}     # Print out final statistics about resource uses before job exits
sstat --format 'JobID,MaxRSS,AveCPU' -P ${SLURM_JOB_ID}.batch
