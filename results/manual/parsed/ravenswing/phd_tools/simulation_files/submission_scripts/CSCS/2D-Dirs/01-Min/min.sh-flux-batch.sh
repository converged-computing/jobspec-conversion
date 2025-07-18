#!/bin/bash
#FLUX: --job-name=min
#FLUX: --queue=normal
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export CRAY_CUDA_MPS='1'
export name='$(cd ..; basename -- "$PWD")'
export GMX='gmx'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export CRAY_CUDA_MPS=1
module load daint-gpu                                                             
module use /apps/daint/UES/6.0.UP07/sandboxes/hvictor/easybuild/modules/all        
module load GROMACS/2018-CrayGNU-18.08-PLUMED-2.4.2-cuda-9.1
export name=$(cd ..; basename -- "$PWD")
export GMX=gmx
cp ../00-Prep/$name.top .
cp ../00-Prep/$name.gro .
cp ../00-Prep/${name}_Protein*.itp . 
$GMX grompp -f min.mdp -c $name.gro -p $name.top -o min.tpr 
srun gmx_mpi mdrun -s min.tpr -ntomp 1 -deffnm min -maxh 1
echo 10 0 | $GMX energy -f min.edr -o ${name}_min_energy.xvg
echo 0 | $GMX trjconv -s min.tpr -f min.trr -o eq.gro -pbc whole
