#!/bin/bash
#FLUX: --job-name=md
#FLUX: --urgency=16

module load gromacs/2020.2-cpu
cpu=$SLURM_NPROCS
sys="AD"
gmx_mpi grompp -f pro.mdp -p ${sys}.top -c NVT_eq.pdb -r NVT_eq.pdb -o pro.tpr -maxwarn 5
mpirun -np $SLURM_NPROCS gmx_mpi mdrun -deffnm md -s pro.tpr -ntomp 8
exit
