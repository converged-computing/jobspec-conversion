#!/bin/bash
#FLUX: --job-name=qsub_example
#FLUX: -n=24
#FLUX: --queue=wildfire
#FLUX: --urgency=16

GMX_VERSION=4.6.7
DEFFNM="md"
TPR="md.tpr"
CPT="state.cpt"
WORK=/scratch/${USER}/WORK/${SLURM_JOB_ID}
mkdir -p $WORK
test -d $WORK || { echo "Could not make directory: ${WORK}"; exit 2; }
cp $CPT $TPR $WORK
cd $WORK || { echo "Could not change directory to: ${WORK}"; exit 2; }
module purge
module load gromacs/${GMX_VERSION}
module load cuda/8.0.61
mdrun_mpi -s $TPR -nsteps 1000 -cpi state.cpt
cp * $SLURM_SUBMIT_DIR
