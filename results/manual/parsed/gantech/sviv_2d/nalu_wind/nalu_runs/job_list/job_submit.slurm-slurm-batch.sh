#!/bin/bash
#SBATCH --job-name=af_smd
#SBATCH --account=sviv
#SBATCH --output=out.%x_%j
#SBATCH --nodes=11
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --array=1-3

export SPACK_MANAGER='~/spack-manager'

export SPACK_MANAGER=~/spack-manager
source ${SPACK_MANAGER}/start.sh
spack-start
spack env activate -d ~/spack-manager/environments/sviv_smd_run/ 
spack load nalu-wind
line_str=$(printf '%dp' ${SLURM_ARRAY_TASK_ID})
directory=$(sed -n $line_str list_of_cases)
printf "%s\n" $directory
cd $directory
srun -n 396 naluX -i *.yaml &> log 
