#!/bin/bash
#SBATCH --job-name=sample_job
#SBATCH --account=pXXXX
#SBATCH --output=outlog_nwchem_7_0_2_intel
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:20:00
#SBATCH --constraint=ntasks-per-node=4,[quest8|quest9|quest10|quest11]

module purge all
module load nwchem/7.0.2-openmpi-4.0.5-intel-19.0.5.281 
mpirun -np ${SLURM_NTASKS} nwchem nwch.nw
