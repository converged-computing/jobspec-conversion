#!/bin/bash
#SBATCH --job-name=mpi_job_test
#SBATCH --account=nvidia-ai
#SBATCH --output=mpi_test_%j.log
#SBATCH --nodes=10
#SBATCH --ntasks=80
#SBATCH --cpus-per-task=1
#SBATCH --gres=80
#SBATCH --mem-per-cpu=60gb
#SBATCH --time=00:05:00
#SBATCH --partition=hpg-ai
#SBATCH --qos=nvidia-ai
#SBATCH --constraint=ntasks-per-node=8

export LAMMPS_PLUGIN_PATH='/home/jinzexue/hackathon/sp2022-hackathon/lammps-ani/build'

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
module load cuda/11.4.3 gcc/9.3.0 openmpi/4.0.5 cmake
cd /red/nvidia-ai/jinzexue/sp2022-hackathon/lammps-ani/example/C2
export LAMMPS_PLUGIN_PATH=/home/jinzexue/hackathon/sp2022-hackathon/lammps-ani/build
srun --mpi=pmix_v3 /red/nvidia-ai/jinzexue/lammps/build/lmp_mpi -in in.plugin.lammps 
