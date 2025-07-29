#!/bin/bash
#SBATCH --job-name=swat_callib_mpi_x
#SBATCH --mail-user=alexander.kmoch@ut.ee
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=7-00:00:00
#SBATCH --constraint=ntasks-per-node=12
#SBATCH --chdir=/gpfs/hpc/home/kmoch/swat

module load openmpi-3.1.0
module load python-3.7.1
source activate daskgeo2020a
mpirun python run_for.py -m $MD1 -s $SP1 -r $REP1 -p $PAR1
