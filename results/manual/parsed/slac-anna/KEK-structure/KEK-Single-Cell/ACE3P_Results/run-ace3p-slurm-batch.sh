#!/bin/bash
#SBATCH --account=m1779
#SBATCH --output=job.%j.out
#SBATCH --error=job.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=debug
#SBATCH --constraint=haswell

cd $SLURM_SUBMIT_DIR
module -s swap PrgEnv-intel PrgEnv-gnu
module load cray-petsc
module load cray-parallel-netcdf
module load cray-hdf5-parallel
module load gsl/2.5
module load cray-tpsl
module load arpack-ng/3.7.0-gcc
module load cray-trilinos
srun -n 1 --cpu_bind=cores /global/cfs/cdirs/ace3p/cori/acdtool meshconvert SingleCell.gen
srun -n 32 --cpu_bind=cores /global/cfs/cdirs/ace3p/cori/omega3p singlecell.omega3p
srun -n 32 --cpu_bind=cores /global/cfs/cdirs/ace3p/cori/track3p singlecell.track3p
