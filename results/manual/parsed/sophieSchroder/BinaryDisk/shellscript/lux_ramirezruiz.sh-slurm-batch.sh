#!/bin/bash
#SBATCH --job-name=q03
#SBATCH --account=ramirez-ruiz
#SBATCH --output=test_%j.log
#SBATCH --mail-user=sschrode@ucsc.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=4
#SBATCH --ntasks=160
#SBATCH --cpus-per-task=1
#SBATCH --time=6-23:59:00
#SBATCH --constraint=ntasks-per-node=40

pwd; hostname; date
echo "Running program on $SLURM_JOB_NUM_NODES nodes with $SLURM_NTASKS total tasks, with each node getting $SLURM_NTASKS_PER_NODE running on cores."
module load intel
module load intel/impi
module load hdf5/1.10.6-parallel
mpirun -n 160 --ppn 40 /home/sschrode/Athena/DISK/BinaryDisk/code/bin/athena -i athinput.binarydisk_stream
date
