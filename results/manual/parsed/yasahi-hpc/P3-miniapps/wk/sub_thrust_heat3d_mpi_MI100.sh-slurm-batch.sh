#!/bin/bash
#SBATCH --job-name=poi_adam
#SBATCH --output=./stdout_%J
#SBATCH --error=./stderr_%J
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --gpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --nodelist=amd1

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module purge
module load openmpi/4.1.1
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
ROCR_VISIBLE_DEVICES=1,2,3 mpirun -n ${SLURM_NTASKS} ../build/miniapps/heat3d_mpi/thrust/heat3d_mpi --nx 512 --ny 512 --nz 512 --px 1 --py 1 --pz 1 --nbiter 1000 --freq_diag 0
