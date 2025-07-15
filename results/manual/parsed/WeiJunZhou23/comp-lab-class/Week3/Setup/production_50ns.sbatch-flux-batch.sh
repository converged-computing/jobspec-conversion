#!/bin/bash
#FLUX: --job-name=gromacs
#FLUX: -t=259200
#FLUX: --urgency=16

module purge
module load gromacs/openmpi/intel/2020.4
srun -n 10 gmx_mpi grompp -f md_50ns.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_2.tpr
srun -n 10 gmx_mpi mdrun -deffnm md_0_2
