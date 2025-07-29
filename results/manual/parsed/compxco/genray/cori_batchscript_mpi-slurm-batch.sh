#!/bin/bash
#SBATCH --job-name=GENRAY
#SBATCH --account=m77
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:02:00
#SBATCH --partition=regular
#SBATCH --qos=premium
#SBATCH --constraint=haswell

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/global/homes/y/ypetrov/pgplot.intel'

cd $SLURM_SUBMIT_DIR
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/global/homes/y/ypetrov/pgplot.intel
srun -n 32 -c 4 --cpu_bind=cores ./xgenray_mpi_intel.cori
