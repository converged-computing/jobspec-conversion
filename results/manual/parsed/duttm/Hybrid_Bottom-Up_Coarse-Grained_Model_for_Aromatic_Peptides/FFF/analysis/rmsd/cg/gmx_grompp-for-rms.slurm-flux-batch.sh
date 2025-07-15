#!/bin/bash
#FLUX: --job-name=ana
#FLUX: --queue=RM-shared
#FLUX: -t=1200
#FLUX: --priority=16

module load gromacs/2018
MODELNO=$1
PEPCT=$2
INPUT=${MODELNO}cg${PEPCT}-5ns.gro
TOPOL=topol_aa${MODELNO}cg${PEPCT}.top
OUTPUT=topol-aa${MODELNO}cg${PEPCT}.tpr
INDEX=index-${MODELNO}cg${PEPCT}.ndx
MDPFILE=grompp_CG-${MODELNO}cg.mdp
echo 1 1 | mpirun -np 1 gmx_mpi grompp -f $MDPFILE -c $INPUT -p $TOPOL -n $INDEX -o $OUTPUT
