#!/bin/bash
#SBATCH --job-name=IL-8-a2b1
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=3-00:00:00
#SBATCH --partition=gpu

export GMX='gmx_mpi'
export GMX_DISABLE_GPU_TIMING='yes'

module load apps/gromacs/2023_plumed_2.9
export GMX=gmx_mpi
FN=$(cd ..; basename -- "$PWD")
traj=metad_${FN}
method=$(cd ../..; basename -- "$PWD")
tpr=prod.tpr
ndx=i.ndx
tmax=500000
export GMX_DISABLE_GPU_TIMING=yes
OMP_NUM_THREADS=24 srun -n 1 -c 24 gmx_mpi mdrun -dlb auto -pin auto -s prod.tpr -deffnm ${traj} -maxh 71.5 -plumed plumed_${FN}.dat -cpi ${traj}.cpt -append
if [ ! -f ${traj}.gro ]; then sbatch _cont.sh;
else
    echo Protein_LIG         | $GMX trjconv -s $tpr -f ${traj}.xtc       -o ${traj}_whole.xtc -pbc whole -n i.ndx
    echo Protein Protein_LIG | $GMX trjconv -s $tpr -f ${traj}_whole.xtc -o ${traj}_clust.xtc -pbc cluster -n i.ndx
    echo Protein Protein_LIG | $GMX trjconv -s $tpr -f ${traj}_clust.xtc -o ${traj}_final.xtc -pbc mol -ur compact -center -n i.ndx
    echo Protein_LIG         | $GMX trjconv -s $tpr -f ${traj}_final.xtc -o ${FN}_short.xtc -dt 10 -n i.ndx
    echo Protein_LIG         | $GMX trjconv -s $tpr -f ${traj}_final.xtc -o ${FN}_lastframe.pdb -b $tmax -e $tmax -n i.ndx
fi
