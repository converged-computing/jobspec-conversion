#!/bin/bash
#FLUX: --job-name=run-gromacs
#FLUX: -t=259200
#FLUX: --urgency=16

cd /scratch/work/courses/CHEM-GA-2671-2022fa/yw5806/comp-lab-class/Inputs/ParallelTemp
module purge
module load gromacs/openmpi/intel/2018.3
srun -n 1 gmx_mpi grompp -f T300/adp_T300.mdp -c ../adp.gro -p ../adp.top -o T300/adp.tpr
srun -n 1 gmx_mpi grompp -f T444/adp_T444.mdp -c ../adp.gro -p ../adp.top -o T444/adp.tpr
srun -n 1 gmx_mpi grompp -f T550/adp_T550.mdp -c ../adp.gro -p ../adp.top -o T550/adp.tpr
srun -n 1 gmx_mpi grompp -f T600/adp_T600.mdp -c ../adp.gro -p ../adp.top -o T600/adp.tpr
