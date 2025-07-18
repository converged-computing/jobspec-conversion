#!/bin/bash
#FLUX: --job-name=gloopy-nalgas-7223
#FLUX: -N=16
#FLUX: --queue=normal
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export CRAY_CUDA_MPS='1'
export FN='$(cd ..; basename -- "$PWD")'
export GMX='gmx'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export CRAY_CUDA_MPS=1
module load daint-gpu                                                             
module use /apps/daint/UES/6.0.UP07/sandboxes/hvictor/easybuild/modules/all        
module load GROMACS/2018-CrayGNU-18.08-PLUMED-2.4.2-cuda-9.1
export FN=$(cd ..; basename -- "$PWD")
export GMX=gmx
srun gmx_mpi mdrun -s mdrun.tpr -ntomp 1 -deffnm md -cpi MDrun.cpt -append -plumed plumed_$FN.dat -maxh 23.5
num=RUN_NUMBER
cp MDrun.cpt MDrun_$num.cpt
cp MDrun_prev.cpt MDrun_${num}_prev.cpt
if [ ! -f MDrun.gro ]; then bash CONT.sh;
else
    echo 0 | $GMX trjconv -s mdrun.tpr -f MDrun.trr -o md_lastframe.gro -b 500000 -e 500000 -pbc whole
    echo Protein | $GMX trjconv -s mdrun.tpr -f MDrun.trr -o ${FN}_protein.gro -b 500000 -e 500000 -pbc whole
    echo 0 | $GMX trjconv -s mdrun.tpr -f MDrun.trr -o MD_reimaged.xtc -pbc whole
    echo Protein Protein | $GMX trjconv -s min.tpr -f MD_reimaged.xtc -o MD_protraj.xtc -pbc nojump -center
    echo Protein Protein | $GMX trjconv -s min.tpr -f MD_protraj.xtc -o MD_cluster.xtc -pbc cluster
    echo Protein Protein | $GMX trjconv -s min.tpr -f MD_cluster.xtc -o MD_final.xtc -pbc mol -ur compact -center
    echo Protein | $GMX trjconv -s min.tpr -f MD_final.xtc -o ${FN}_protein.pdb -b 500000 -e 500000
    echo Protein | $GMX gyrate -s min.tpr -f MD_final.xtc -o ${FN}_Rgyr.xvg
    echo Backbone Backbone | $GMX rms -s min.tpr -f MD_final.xtc -o ${FN}_RMSD.xvg -fit rot+trans
fi
