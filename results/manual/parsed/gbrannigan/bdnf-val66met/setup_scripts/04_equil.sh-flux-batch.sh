#!/bin/bash
#FLUX: --job-name=stinky-citrus-8506
#FLUX: --urgency=16

export GMX_MAXBACKUP='-1'
export OMP_NUM_THREADS='2 # gives 4-12ns/day performance,15-6ns/day,1-7ns/day,2-4.log,8-5.log,4-6.log '

module purge
module load intel/15.0.2
module load mvapich2/2.1
module load boost
module load gromacs/5.1.2
module list
export GMX_MAXBACKUP=-1
export OMP_NUM_THREADS=2 # gives 4-12ns/day performance,15-6ns/day,1-7ns/day,2-4.log,8-5.log,4-6.log 
REP=$(seq 0 63)
module list
mdp=/scratch/02780/ruchi/trex-04/mdp_files
echo "13" > ../inp
for i in $REP
do
cd $i
ibrun -np 1 gmx grompp -f $mdp/em.mdp -c pre_em.gro -p topol.top -o em.tpr >& grompp_6.out
cd ..
done
ibrun -np $SLURM_NTASKS mdrun_mpi -deffnm em -multidir $REP
for i in $REP
do
cd $i
ibrun -np 1 gmx grompp -f $mdp/nvt.mdp -c em.gro -p topol.top -o nvt.tpr >& grompp_7.out
cd ..
done
ibrun -np $SLURM_NTASKS mdrun_mpi -deffnm nvt -multidir $REP
for i in $REP
do
cd $i
ibrun -np 1 gmx grompp -f $mdp/npt.mdp -c nvt.gro -p topol.top -o npt.tpr -t nvt.cpt >& grompp_8.out 
cd ..
done
ibrun -np $SLURM_NTASKS mdrun_mpi -v -noappend -deffnm npt -multidir $REP
