#!/bin/bash
#FLUX: --job-name=2L_ray
#FLUX: -t=172800
#FLUX: --priority=16

export NUM_JULIA_THREADS='`nproc`'

module purge
export NUM_JULIA_THREADS=`nproc`
rundir=$SCRATCH/twolayer_raytracing/$SLURM_JOB_ID
mkdir -p $rundir
cp driver.sbatch Driver.jl TwoLayerRaytracing.jl Raytracing.jl initial_condition.jld2 $rundir
cp initial_condition_U0.1.jld2 $rundir/initial_condition.jld2
cp Parameters.jl $rundir/Parameters.jl
cd $rundir
julia -t $SLURM_CPUS_PER_TASK Driver.jl > run.log
exit
