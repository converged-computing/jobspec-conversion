#!/bin/bash
#SBATCH --job-name=plot_TY
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10GB
#SBATCH --time=01:30:00
#SBATCH --constraint=ntasks-per-node=1

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
