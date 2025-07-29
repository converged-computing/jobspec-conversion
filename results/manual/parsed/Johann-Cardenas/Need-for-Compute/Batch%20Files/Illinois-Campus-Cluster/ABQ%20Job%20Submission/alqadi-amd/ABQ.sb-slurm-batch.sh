#!/bin/bash
#SBATCH --job-name=NB1DSUMW
#SBATCH --mail-user=johannc2@illinois.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=200G
#SBATCH --time=4-00:00:00
#SBATCH --partition=alqadi-amd
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --nodelist=ccc0324

module use /projects/eng/modulefiles
module load abaqus/2023
module load intel/20.4
module load cuda/11.1
unset SLURM_GTIDS
abaqus inp=NB1DSUMW job=NB1DSUMW user=UMAT scratch=/scratch/users/johannc2/NB1DSUMW cpus=16 gpus=1 mp_mode=mpi memory=200000mb interactive
module unload cuda/11.1
module unload intel/20.4
module unload abaqus/2023
