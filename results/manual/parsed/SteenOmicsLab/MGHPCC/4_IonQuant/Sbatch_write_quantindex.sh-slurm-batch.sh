#!/bin/bash
#SBATCH --job-name=quantWrite
#SBATCH --account=bch-mghpcc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=89GB
#SBATCH --time=06:00:00
#SBATCH --partition=mghpcc-short

export LC_ALL='C'

export LC_ALL=C
source $1/settings/settings.sh
module load singularity
singularity exec --bind $inputdirectory,$outputdirectory,$fragpipeDirectory $container $1/settings/IonQuant/Write_quantindex.sh "$1" "$SLURM_JOBID" "$SLURM_ARRAY_TASK_ID"
