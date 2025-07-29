#!/bin/bash
#SBATCH --output=R_%x_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --gres=gpu:1
#SBATCH --time=1-12:00:00
#SBATCH --partition=gm4-pmext
#SBATCH --qos=gm4
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=4

NCPU=$(($SLURM_NTASKS_PER_NODE))
NTHR=$(($SLURM_CPUS_PER_TASK))
NNOD=$(($SLURM_JOB_NUM_NODES))
NP=$(($NCPU * $NNOD * $NTHR))
module unload openmpi gcc cuda python
module load openmpi/4.1.1+gcc-10.1.0 cuda/11.2
source /project/andrewferguson/armin/grom_new/gromacs-2021.6/installed-files-mw2-256/bin/GMXRC
gmx mdrun -ntomp "$NP" -plumed reweight.dat -s ../md.tpr -rerun ../md.xtc
