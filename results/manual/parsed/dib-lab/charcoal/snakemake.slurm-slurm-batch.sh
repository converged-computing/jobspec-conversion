#!/bin/bash
#SBATCH --job-name=charcoal
#SBATCH --mail-user=titus@idyll.org
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=60000
#SBATCH --time=02:00:00

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
