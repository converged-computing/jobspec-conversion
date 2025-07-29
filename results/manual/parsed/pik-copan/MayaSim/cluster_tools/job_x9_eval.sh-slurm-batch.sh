#!/bin/bash
#SBATCH --job-name=Maya_9_eval
#SBATCH --account=copan
#SBATCH --output=ms_x9_eval_%j.out
#SBATCH --error=ms_x9_eval_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --qos=priority

export I_MPI_PMI_LIBRARY='/p/system/slurm/lib/libpmi.so'
export OMP_NUM_THREADS='1'

module load compiler/intel/16.0.0
module load hpc/2015 anaconda/2.3.0
export I_MPI_PMI_LIBRARY=/p/system/slurm/lib/libpmi.so
export OMP_NUM_THREADS=1
source activate mayasim
echo "------------------------------------------------------------"
echo "SLURM JOB ID: $SLURM_JOBID"
echo "$SLURM_NTASKS tasks"
echo "------------------------------------------------------------"
cd ../Experiments/
srun -n $SLURM_NTASKS python mayasim_X9_stability_analysis.py 0 2
