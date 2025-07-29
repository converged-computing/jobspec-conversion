#!/bin/bash
#FLUX: --job-name=2Lray
#FLUX: -c=48
#FLUX: -t=601200
#FLUX: --urgency=16

export NUM_JULIA_THREADS='`nproc`'

module purge
export NUM_JULIA_THREADS=`nproc`
config=parameters.txt
initial_condition_file=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)
rundir=$SCRATCH/twolayer_raytracing/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID}
mkdir -p $rundir
cp array-driver.sbatch Driver.jl TwoLayerRaytracing.jl Raytracing.jl $rundir
cp $initial_condition_file $rundir/initial_condition.jld2
cp ArrayParameters.jl $rundir/Parameters.jl
cd $rundir
julia -t $SLURM_CPUS_PER_TASK Driver.jl > run.log
exit
