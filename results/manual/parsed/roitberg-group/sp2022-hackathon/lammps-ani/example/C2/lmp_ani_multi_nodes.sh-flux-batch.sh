#!/bin/bash
#FLUX: --job-name=mpi_job_test
#FLUX: -N=10
#FLUX: -n=80
#FLUX: --queue=hpg-ai
#FLUX: -t=300
#FLUX: --urgency=16

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
