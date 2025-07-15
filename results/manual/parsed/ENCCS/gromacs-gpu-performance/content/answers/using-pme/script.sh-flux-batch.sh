#!/bin/bash
#FLUX: --job-name=nerdy-squidward-1126
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=900
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module purge
module load gromacs-env/2021-gpu
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
options="-nsteps 20000 -resetstep 19000 -ntomp $SLURM_CPUS_PER_TASK -pin on -pinstride 1"
srun gmx mdrun $options -g default.log
srun gmx mdrun $options -g manual-nb.log           -nb gpu -pme cpu
srun gmx mdrun $options -g manual-nb-pmeall.log    -nb gpu -pme gpu
srun gmx mdrun $options -g manual-nb-pmefirst.log  -nb gpu -pme gpu -pmefft cpu
echo Done
rm -f *cpt *edr *trr *tng *gro \#*
