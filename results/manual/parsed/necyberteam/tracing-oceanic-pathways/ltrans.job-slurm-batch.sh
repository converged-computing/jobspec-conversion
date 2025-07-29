#!/bin/bash
#SBATCH --output=jobname.job.%A.out
#SBATCH --error=jobname.job.%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2048
#SBATCH --time=11:30:00
#SBATCH --constraint=centos7

filename=jobname
set -x
hostname
date
STORAGE_DIR="/home/$USER/${SLURM_JOB_ID}.${filename}"
mkdir -pv $STORAGE_DIR
WORKING_DIR=$(pwd)
echo ">> These are the files that are in $WORKING_DIR << "
ls -l
module add singularity/3.2.1
singularity exec docker://ncolella/ltrans:latest cp /home/ltrans/LTRANSv2b/netcdf.inc $WORKING_DIR
singularity exec docker://ncolella/ltrans:latest cp /home/ltrans/LTRANSv2b/netcdf.mod $WORKING_DIR
singularity exec docker://ncolella/ltrans:latest cp /home/ltrans/LTRANSv2b/makefile $WORKING_DIR
singularity exec docker://ncolella/ltrans:latest make
singularity exec docker://ncolella/ltrans:latest ./LTRANS.exe
echo "VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV"
echo -n ">> Job finished @ "
date
echo ">> Output can be found in: $STORAGE_DIR"
