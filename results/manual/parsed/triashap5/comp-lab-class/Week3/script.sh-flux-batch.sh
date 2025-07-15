#!/bin/bash
#FLUX: --job-name=run-gromacs
#FLUX: -t=172800
#FLUX: --priority=16

module purge
module load gromacs/openmpi/intel/2020.4
mpirun -np 1 gmx_mpi grompp -f md-50ns.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_50.tpr
mpirun gmx_mpi mdrun -deffnm md_0_1
echo "Production Done" >> output.out
