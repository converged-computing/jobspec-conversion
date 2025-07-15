#!/bin/bash
#FLUX: --job-name=run-gromacs
#FLUX: -t=259200
#FLUX: --urgency=16

cd /scratch/work/courses/CHEM-GA-2671-2022fa/yw5806/comp-lab-class/Week3/Data/MD50ns 
module purge
module load gromacs/openmpi/intel/2020.4
srun -n 10 gmx_mpi grompp -f md50ns.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_50.tpr
srun -n 10 gmx_mpi mdrun -v -deffnm md_0_50
