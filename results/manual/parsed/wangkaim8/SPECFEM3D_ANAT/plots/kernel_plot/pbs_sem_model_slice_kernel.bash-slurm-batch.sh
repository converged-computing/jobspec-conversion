#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/wangkaim8/SPECFEM3D_ANAT/plots/kernel_plot/pbs_sem_model_slice_kernel.bash
