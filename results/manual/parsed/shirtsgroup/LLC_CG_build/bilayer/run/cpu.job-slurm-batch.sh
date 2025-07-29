#!/bin/bash
#SBATCH --job-name=GI_5
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00
#SBATCH --partition=RM-shared
#SBATCH --constraint=ntasks-per-node=16

export GMX_MAXBACKUP='-1  # do not make back-ups'
export GMX_MAXCONSTRWARN='-1'

module load gcc
source /jet/home/susa/pkgs/gromacs/2020.5/bin/GMXRC
export GMX_MAXBACKUP=-1  # do not make back-ups
export GMX_MAXCONSTRWARN=-1
cp ../prepare/bilayer_prod.gro ./
i=0
if [ ! -f prod_$i.xtc ]; then
    gmx grompp -f prod.mdp -p itw_gly.top -c bilayer_prod.gro -o prod_$i
    gmx mdrun -v -deffnm prod_$i -nt 16 -ntomp 1
elif [ ! -f prod_$i.gro ]; then
    gmx mdrun -v -deffnm prod_$i -cpi prod_$i.cpt -nt 16 -ntomp 1
fi
i=1
j=0
if [ ! -f prod_$i.xtc ]; then
    gmx grompp -f prod.mdp -p itw_gly.top -c prod_$j.gro -o prod_$i
    gmx mdrun -v -deffnm prod_$i -nt 16 -ntomp 1
elif [ ! -f prod_$i.gro ]; then
    gmx mdrun -v -deffnm prod_$i -cpi prod_$i.cpt -nt 16 -ntomp 1
fi
