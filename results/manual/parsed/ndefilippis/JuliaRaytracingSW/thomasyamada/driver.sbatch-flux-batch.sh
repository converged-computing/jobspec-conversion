#!/bin/bash
#FLUX: --job-name=thomasyamada_simulation
#FLUX: -c=36
#FLUX: -t=43200
#FLUX: --urgency=16

export NUM_JULIA_THREADS='`nproc`'

module purge
export NUM_JULIA_THREADS=`nproc`
rundir=$SCRATCH/thomasyamada_simulation/$SLURM_JOB_ID
mkdir -p $rundir
cp driver.sbatch Parameters.jl ThomasYamada.jl TYdriver.jl TYUtils.jl $rundir
cd $rundir
julia -t $SLURM_CPUS_PER_TASK TYdriver.jl CPU > run.log
exit
