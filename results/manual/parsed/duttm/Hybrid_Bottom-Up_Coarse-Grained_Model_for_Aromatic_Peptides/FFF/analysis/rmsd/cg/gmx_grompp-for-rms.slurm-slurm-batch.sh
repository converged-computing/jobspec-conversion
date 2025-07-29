#!/bin/bash
#SBATCH --job-name=ana
#SBATCH --output=slurm.%N.%j.out
#SBATCH --mail-user=mh1314@scarletmail.rutgers.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --partition=RM-shared
#SBATCH --constraint=ntasks-per-node=16

module load gromacs/2018
MODELNO=$1
PEPCT=$2
INPUT=${MODELNO}cg${PEPCT}-5ns.gro
TOPOL=topol_aa${MODELNO}cg${PEPCT}.top
OUTPUT=topol-aa${MODELNO}cg${PEPCT}.tpr
INDEX=index-${MODELNO}cg${PEPCT}.ndx
MDPFILE=grompp_CG-${MODELNO}cg.mdp
echo 1 1 | mpirun -np 1 gmx_mpi grompp -f $MDPFILE -c $INPUT -p $TOPOL -n $INDEX -o $OUTPUT
