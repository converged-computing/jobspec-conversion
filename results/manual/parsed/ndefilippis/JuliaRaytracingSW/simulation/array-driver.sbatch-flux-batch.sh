#!/bin/bash
#FLUX: --job-name=2Lsim
#FLUX: -t=43200
#FLUX: --priority=16

export NUM_JULIA_THREADS='`nproc`'

module purge
export NUM_JULIA_THREADS=`nproc`
config=parameters.txt
U=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)
rundir=$SCRATCH/twolayer_simulation/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID}
mkdir -p $rundir
cp TwoLayerSimulation.jl Driver.jl driver.sbatch $rundir
cp ArrayParameters.jl $rundir/Parameters.jl
cd $rundir
julia -t $SLURM_CPUS_PER_TASK Driver.jl $U > run.log
exit
