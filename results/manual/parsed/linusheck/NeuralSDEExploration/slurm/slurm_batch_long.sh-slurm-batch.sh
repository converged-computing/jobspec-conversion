#!/bin/bash
#SBATCH --job-name=train
#SBATCH --account=tipes
#SBATCH --output=/home/linushe/outputs/%x.%A_%4a.out
#SBATCH --mail-user=linus.heck@rwth-aachen.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=50G
#SBATCH --time=4-04:00:00
#SBATCH --partition=standard
#SBATCH --qos=medium

export I_MPI_PMI_LIBRARY='/p/system/slurm/lib/libpmi.so'

echo "------------------------------------------------------------"
echo "SLURM JOB ID: $SLURM_JOBID"
echo "Running on nodes: $SLURM_NODELIST"
echo "------------------------------------------------------------"
export I_MPI_PMI_LIBRARY=/p/system/slurm/lib/libpmi.so
module purge
module load julia
./$1
