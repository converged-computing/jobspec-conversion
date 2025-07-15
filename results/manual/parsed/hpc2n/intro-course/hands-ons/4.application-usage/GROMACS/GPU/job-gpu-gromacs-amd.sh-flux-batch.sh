#!/bin/bash
#FLUX: --job-name=purple-kitty-2122
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    mdargs="-ntomp $SLURM_CPUS_PER_TASK"
else
    mdargs="-ntomp 1"
fi
nvidia-smi
echo $CUDA_VISIBLE_DEVICES 
ml purge > /dev/null 2>&1
ml GCC/11.3.0  OpenMPI/4.1.4
ml GROMACS/2023.1-CUDA-11.7.0
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
gmx grompp -f step4.1_equilibration-amd.mdp -o step4.1_equilibration-amd.tpr -c step4.0_minimization.gro -r step3_charmm2gmx.pdb -n index.ndx -p topol.top
gmx mdrun -nb gpu -pme gpu -bonded gpu -update gpu -ntomp 12 -ntmpi 1 -dlb yes  -v -deffnm step4.1_equilibration-amd
