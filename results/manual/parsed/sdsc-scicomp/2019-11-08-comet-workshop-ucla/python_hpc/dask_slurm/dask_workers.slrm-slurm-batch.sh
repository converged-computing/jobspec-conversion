#!/bin/bash
#SBATCH --job-name=dask-workers
#SBATCH --output=dask-workers.%j.%N.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --partition=compute
#SBATCH --constraint=ntasks-per-node=24

export SINGULARITY_BINDPATH='/oasis'

module load singularity
SINGULARITY_IMAGE="/oasis/scratch/comet/zonca/temp_project/zonca-singularity-comet-master-2019-05.simg"
COMMAND="bash ./launch_worker.sh"
export SINGULARITY_BINDPATH="/oasis"
ibrun --npernode=1 singularity exec $SINGULARITY_IMAGE $COMMAND
