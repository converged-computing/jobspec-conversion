#!/bin/bash
#FLUX: --job-name=m9res
#FLUX: --priority=16

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
srun -n $SLURM_NTASKS python res_x9.py -i ../output_data/X9_stability_analysis/results/all_trajectories -o ../output_data/X9_stability_analysis/results/all_trajectories.df5
