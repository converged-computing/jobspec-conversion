#!/bin/bash
#SBATCH --job-name=job_22
#SBATCH --output=std-out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1,v100s

export OMP_NUM_THREADS='10'

export OMP_NUM_THREADS=10
cd $SLURM_SUBMIT_DIR
/opt/nvidia/hpc_sdk/Linux_x86_64/22.5/comm_libs/mpi/bin/mpirun /home/myless/VASP/vasp.6.3.2/bin/vasp_std
exit
