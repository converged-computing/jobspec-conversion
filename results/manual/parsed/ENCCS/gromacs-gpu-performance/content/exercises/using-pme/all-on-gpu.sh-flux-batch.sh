#!/bin/bash
#FLUX: --job-name=expensive-carrot-4008
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=900
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module purge
module load gromacs-env/2021-gpu
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
options="-nsteps 20000 -resetstep 19000 -ntomp $SLURM_CPUS_PER_TASK -pin on -pinstride 1"
srun gmx mdrun $options -g manual-nb-pme-update.log        **FIXME**
srun gmx mdrun $options -g manual-nb-pme-bonded-update.log **FIXME**
echo Done
rm -f *cpt *edr *trr *tng *gro \#*
