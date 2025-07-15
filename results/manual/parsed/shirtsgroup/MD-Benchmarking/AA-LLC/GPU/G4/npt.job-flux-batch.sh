#!/bin/bash
#FLUX: --job-name=bumfuzzled-hobbit-8298
#FLUX: --urgency=16

export GMX_MAXBACKUP='-1  # do not make back-ups'

module load cuda
module load gcc/10.2.0
module load openmpi/3.1.6-gcc10.2.0
source /jet/home/susa/pkgs/gromacs/2020.5_gpu/bin/GMXRC
export GMX_MAXBACKUP=-1  # do not make back-ups
mpirun -np 4 gmx_mpi mdrun -v -s ../npt.tpr -o npt -g  G4_np4_nomp4.log  -ntomp 4
mpirun -np 8 gmx_mpi mdrun -v -s ../npt.tpr -o npt -g  G4_np8_nomp2.log  -ntomp 2
mpirun -np 16 gmx_mpi mdrun -v -s ../npt.tpr -o npt -g  G4_np16_nomp1.log  -ntomp 1
mpirun -np 20 gmx_mpi mdrun -v -s ../npt.tpr -o npt -g  G4_np20_nomp1.log  -ntomp 1
