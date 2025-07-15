#!/bin/bash
#FLUX: --job-name=hairy-bike-0077
#FLUX: --priority=16

export GMX_MAXBACKUP='-1'
export OMP_NUM_THREADS='15'

module purge
module load intel/15.0.2
module load mvapich2/2.1
module load boost
module load cuda/7.0
module load gromacs/5.1.2
module list
export GMX_MAXBACKUP=-1
export OMP_NUM_THREADS=15
module list
( for i in {0..63} ; do cd $i ; echo 0 > pro ; ibrun -np 1  gmx grompp -f rep_"$i".mdp -t ex.cpt -c nvt_vol.gro -p topol.top -o ex.tpr  >& grompp_11.out ; cd .. ; done ) 
ibrun -np 480 mdrun_mpi_gpu -noappend -v -deffnm ex -multidir {0..63} -maxh 1 -replex 500 -nstlist 20
