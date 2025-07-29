#!/bin/bash
#SBATCH --job-name=tps_bte
#SBATCH --account=FTA-SUB-Ghattas
#SBATCH --output=tps_bte.o%j
#SBATCH --error=tps_bte.e%j
#SBATCH --mail-user=uvilla@oden.utexas.edu
#SBATCH --mail-type=all
#SBATCH --nodes=2
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=gpu-a100

module purge
module load gcc/11.2.0 mvapich2/2.3.7 tacc-apptainer/1.1.8 cuda/12.2
ml list
MV2_SMP_USE_CMA=0 ibrun apptainer run --nv tps-bte-ls6_latest.sif /tps/build-gpu/src/tps-bte_0d3v.py -run input.ini
