#!/bin/bash
#FLUX: --job-name=myxo-sim
#FLUX: -n=9
#FLUX: -t=82800
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module purge
module load matlab/R2020b
matlab -singleCompThread -nodisplay -nosplash -r Initial_all
module purge
module load intel/19.1.1.217
module load intel-mpi/intel/2019.7
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun $HOME/.local/bin/lmp_della -in in.spfr3Dall_exp
