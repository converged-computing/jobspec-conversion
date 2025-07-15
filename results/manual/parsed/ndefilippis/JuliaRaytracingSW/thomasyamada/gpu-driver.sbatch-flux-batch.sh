#!/bin/bash
#FLUX: --job-name=gpu_thomasyamada_simulation
#FLUX: -t=57600
#FLUX: --priority=16

export NUM_JULIA_THREADS='`nproc`'

module purge
export NUM_JULIA_THREADS=`nproc`
rundir=$SCRATCH/thomasyamada_simulation/$SLURM_JOB_ID
mkdir -p $rundir
cp gpu-driver.sbatch Parameters.jl ThomasYamada.jl TYdriver.jl TYUtils.jl $rundir
cd $rundir
julia -t $SLURM_CPUS_PER_TASK TYdriver.jl GPU > run.log
exit
