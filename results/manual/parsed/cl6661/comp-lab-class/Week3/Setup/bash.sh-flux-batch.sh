#!/bin/bash
#FLUX: --job-name=run-gromace
#FLUX: -t=86400
#FLUX: --priority=16

module purge
module load gromacs/openmpi/intel/2020.4
mpirun -np 1 gmx_mpi grompp -f minim.mdp -c 1AKI_solv_ions.gro -p topol.top -o 1AKI_solv_ions_em.tpr
mpirun -np 1 gmx_mpi mdrun -s 1AKI_solv_ions_em.tpr -deffnm 1AKI_solv_ions_em
mpirun -np 1 gmx_mpi grompp -f nvt.mdp -c 1AKI_solv_ions_em.gro -r 1AKI_solv_ions_em.gro -p topol.top -o nvt.tpr
mpirun gmx_mpi mdrun -deffnm nvt
mpirun -np 1 gmx_mpi grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
mpirun gmx_mpi mdrun -deffnm npt
mpirun -np 1 gmx_mpi grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_1.tpr
mpirun gmx_mpi mdrun -deffnm md_0_1
