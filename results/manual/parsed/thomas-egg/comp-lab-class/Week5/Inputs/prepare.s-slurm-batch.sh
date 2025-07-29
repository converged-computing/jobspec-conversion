#!/bin/bash
#SBATCH --job-name=prepare
#SBATCH --mail-user=tje3676@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3GB
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=3

module purge
module load gromacs/openmpi/intel/2018.3
gmx_mpi grompp -f adp_T300.mdp -c adp.gro -p adp.top -o T300/adp.tpr
