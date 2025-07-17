#!/bin/bash
#FLUX: --job-name=delicious-snack-9297
#FLUX: -N=5
#FLUX: --queue=sgpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load intel
module load impi
module load mkl
source /projects/beco4952/pkgs/gromacs/2018_gpu/bin/GMXRC
for dir in sim{0..19}; do cd $dir; gmx grompp -f berendsen.mdp -c em_solvated.gro -p topol.top -o berendsen; cd ..; done
mpirun -np 20 gmx_mpi mdrun -v -multidir sim{0..19} -deffnm berendsen -ntomp 6
