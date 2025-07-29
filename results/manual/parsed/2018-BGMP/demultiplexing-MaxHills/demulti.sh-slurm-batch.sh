#!/bin/bash
#SBATCH --job-name=Hills_demultiplex
#SBATCH --output=/projects/bgmp/mhills/demultiplex/slurm_demultiplex.out
#SBATCH --error=/projects/bgmp/mhills/demultiplex/slurm_demultiplex.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=09:00:00
#SBATCH --constraint=ntasks-per-node=28

cd /projects/bgmp/mhills/demultiplex
module purge
module load easybuild intel/2017a Python/3.6.1 icc/2017.1.132-GCC-6.3.0-2.27 impi/2017.1.132 ifort/2017.1.132-GCC-6.3.0-2.27 impi/2017.1.132 matplotlib/2.0.1-Python-3.6.1 
python demulti.py
