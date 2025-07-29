#!/bin/bash
#SBATCH --job-name=alf_NGC4365_SN100
#SBATCH --account=durham
#SBATCH --output=/cosma5/data/durham/dc-poci1/alf/NGC4365/out.log
#SBATCH --error=/cosma5/data/durham/dc-poci1/alf/NGC4365/out.log
#SBATCH --mail-user=adriano.poci@durham.ac.uk
#SBATCH --mail-type=TIME_LIMIT_90,TIME_LIMIT,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=3000
#SBATCH --time=2-00:00:00
#SBATCH --partition=cosma
#SBATCH --chdir=/cosma5/data/durham/dc-poci1/alf/NGC4365
#SBATCH --array=0-330

export ALF_HOME='/cosma5/data/durham/dc-poci1/alf/'

source ${HOME}/.bashrc
module load gnu_comp
module load python/3.10.7
module load openmpi/20190429
module load cmake/3.18.1
export ALF_HOME=/cosma5/data/durham/dc-poci1/alf/
cd ${ALF_HOME}
declare idx=$(printf %04d $((${SLURM_ARRAY_TASK_ID} + 1320)))
mpirun --oversubscribe -np ${SLURM_CPUS_PER_TASK} ./NGC4365/bin/alf.exe "NGC4365_SN100_${idx}" 2>&1 | tee -a "NGC4365/out_${idx}.log"
