#!/bin/bash
#SBATCH --job-name=Download_2_Morph
#SBATCH --account=PAS2136
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:30:00

export SBATCH_ACCOUNT='$SLURM_JOB_ACCOUNT'

set -e
WORKDIR=$1
INPUTCSV=$2
NUMJOBS=$3
if [ -z "$NUMJOBS" ]
then
      NUMJOBS=4
fi
REAL_INPUTCSV=$(realpath $INPUTCSV)
if [ ! -f "$REAL_INPUTCSV" ]
then
   echo "ERROR: Required INPUTCSV file $INPUTCSV does not exist."
   exit 1
fi
module load miniconda3/4.10.3-py37
source activate snakemake
export SBATCH_ACCOUNT=$SLURM_JOB_ACCOUNT
snakemake \
    --jobs $NUMJOBS \
    --profile slurm/ \
    --use-singularity \
    --directory $WORKDIR \
    --config list=$REAL_INPUTCSV
chmod -R 774 $WORKDIR
