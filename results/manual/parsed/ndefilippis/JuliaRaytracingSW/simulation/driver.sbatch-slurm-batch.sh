#!/bin/bash
#FLUX: --job-name=2Lsim
#FLUX: -t=43200
#FLUX: --urgency=16

export NUM_JULIA_THREADS='`nproc`'

module purge
export NUM_JULIA_THREADS=`nproc`
rundir=$SCRATCH/twolayer_simulation/$SLURM_JOB_ID
mkdir -p $rundir
cp TwoLayerSimulation.jl Driver.jl driver.sbatch $rundir
cp Parameters.jl $rundir/Parameters.jl
cd $rundir
julia -t $SLURM_CPUS_PER_TASK Driver.jl > run.log
exit
