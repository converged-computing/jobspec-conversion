#!/bin/bash
#FLUX: --job-name=plot_TY
#FLUX: -c=4
#FLUX: -t=5400
#FLUX: --urgency=16

export NUM_JULIA_THREADS='`nproc`'

module purge
export NUM_JULIA_THREADS=`nproc`
echo $1 > filename.txt
rundir=$SCRATCH/thomasyamada_simulation/$SLURM_JOB_ID
mkdir -p $rundir
cp plot-driver.sbatch makeTYplot.jl TYUtils.jl $rundir
cd $rundir
julia -t $SLURM_CPUS_PER_TASK makeTYplot.jl $1 > run.log
exit
