#!/bin/bash
#FLUX: --job-name=V4
#FLUX: --queue=normal
#FLUX: -t=3600
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
module list
mdp=/scratch/02780/ruchi/trex-03/mdp_files #mdp_files folder is provided
echo "13" > inp
for i in {0..63}
do
cd $i
ibrun -np 1 gmx grompp -f $mdp/em.mdp -c NMR-capped-solvated.gro -p topol.top -o ions.tpr >& grompp_4.out && \
ibrun -np 1 gmx genion -s ions.tpr -o pre_em.gro -p topol.top -pname NA -nname CL -neutral -conc 0.15 < ../inp >& genion_5.out && \
cd ..
done
