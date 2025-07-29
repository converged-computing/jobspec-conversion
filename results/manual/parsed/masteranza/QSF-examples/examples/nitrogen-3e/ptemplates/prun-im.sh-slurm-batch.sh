#!/bin/bash
#SBATCH --job-name=N3e-im-COMPRESSED
#SBATCH --account=plgjonizacja5
#SBATCH --output=%x.out
#SBATCH --error=%x.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=24Gb
#SBATCH --time=3-00:00:00
#SBATCH --partition=plgrid
#SBATCH --constraint=ntasks-per-node=4

srun /bin/hostname
module load plgrid/tools/cmake plgrid/libs/fftw/3.3.9 plgrid/libs/mkl/2021.3.0 plgrid/tools/intel/2021.3.0
cd $SLURM_SUBMIT_DIR
prj=`basename "$PWD"`
mpiexec ./qsf-${prj}-3e-im PARAMS -r
