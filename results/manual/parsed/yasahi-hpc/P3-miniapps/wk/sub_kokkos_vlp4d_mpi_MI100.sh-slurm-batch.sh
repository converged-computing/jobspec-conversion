#!/bin/bash
#SBATCH --job-name=poi_adam
#SBATCH --output=./stdout_%J
#SBATCH --error=./stderr_%J
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=64
#SBATCH --gpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --nodelist=amd1

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module purge
module load openmpi/4.1.1
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
ROCR_VISIBLE_DEVICES=1,2,3 mpirun -n ${SLURM_NTASKS} ../build/miniapps/vlp4d_mpi/kokkos/vlp4d_mpi --num_threads 1 --teams 1 --device 0 --num_gpus 3 --device_map 1 -f SLD10.dat
