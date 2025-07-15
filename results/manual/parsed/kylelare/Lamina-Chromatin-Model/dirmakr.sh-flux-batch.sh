#!/bin/bash
#FLUX: --job-name=chromatin
#FLUX: -n=8
#FLUX: --queue=#partition name here
#FLUX: -t=86100
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

tx=1.1
path=/scratch/kl76/data/$tx
fname="init5.slurm"
partn="common"
cons='"opath"'
home=/scratch/kl76/data/
GMX='$GMX'
MDR='$MDR'
mkdir $path
cd $path
for cx in 0.2; do
  mkdir $path/$cx
  for dSR in run1 run2 run3 run4 run5; do
    mkdir $path/$cx/$dSR
    cd
    cd $home
    #cp seq_C21.txt $path/$cx#/$dSR/$dLR
    #cp gamingedit.py $path/$cx#/$dSR/$dLR
    #cp gamingedit2.py $path/$cx/$dSR
    #cp wall.py $path/$cx/$dSR  
    #cp seqwall.txt $path/$cx/$dSR
    #cp walls-restraint.gro $path/$cx/$dSR
    #cp wall-init-snap.gro $path/$cx/$dSR
    #cp MDP-sim-no-anneal.mdp $path/$cx/$dSR
    cp HI-C.py $path/$cx/$dSR
    cd $path/$cx/$dSR
    name="C21-GM12878"
    content="#!/bin/bash -l
export OMP_NUM_THREADS=1
module load icc/2019.3.199-GCC-8.3.0  impi/2019.4.243 GROMACS/2019.5 Anaconda2
GMX=/opt/apps/software/MPI/intel/2019.3.199-GCC-8.3.0/impi/2019.4.243/GROMACS/2019.5/bin/gmx
MDR=/opt/apps/software/MPI/intel/2019.3.199-GCC-8.3.0/impi/2019.4.243/GROMACS/2019.5/bin/mdrun_mpi
name="C21-GM12878"
srun -n 1 python HI-C.py -f all-$name-$cx-$dSR.gro -n $name-$cx-$dSR
"
    echo "$content">$fname
    sbatch $fname
  done
done
exit 0
