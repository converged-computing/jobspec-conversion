#!/bin/bash
#FLUX: --job-name=MD_lin_para
#FLUX: -N=4
#FLUX: --queue=normal
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export CRAY_CUDA_MPS='1'
export EASYBUILD_PREFIX='/users/revans/programs/gromacs'
export FN='$(cd ..; basename -- "$PWD")'
export GMX='gmx'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export CRAY_CUDA_MPS=1
export EASYBUILD_PREFIX=/users/revans/programs/gromacs
module load daint-gpu
module use $EASYBUILD_PREFIX/modules/all
module load GROMACS
export FN=$(cd ..; basename -- "$PWD")
export GMX=gmx
cp ../02-NVT/i.ndx .
cp ../01-Min/min.tpr .
cp ../04-NPT2/NPT2.cpt .
cp ../04-NPT2/$FN.top .
cp ../04-NPT2/NPT2ed.gro .
cp ../00-Prep/posre_*.itp .
cp ../00-Prep/${FN}_Protein*.itp . 
$GMX  grompp -f md.mdp -c NPT2ed.gro -p $FN.top -o md.tpr -t NPT2.cpt -maxwarn 1 -r NPT2ed.gro -n i.ndx
srun gmx_mpi mdrun -s md.tpr -ntomp 1 -deffnm md -maxh 24
cp md.cpt md_1.cpt
cp md_prev.cpt md_1_prev.cpt
