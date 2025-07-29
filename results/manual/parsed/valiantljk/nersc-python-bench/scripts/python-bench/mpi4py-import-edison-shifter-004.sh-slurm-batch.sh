#!/bin/bash
#SBATCH --job-name=mpi4py-import-edison-shifter-004
#SBATCH --account=nstaff
#SBATCH --output=logs/mpi4py-import-edison-shifter-004-%j.out
#SBATCH --mail-user=rcthomas@lbl.gov
#SBATCH --mail-type=FAIL
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=regular
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=24

export OMP_NUM_THREADS='1'

singularity
exec
docker:rcthomas/nersc-python-bench:0.1.6
commit=true
module load shifter
if [ $commit = true ]; then
    shifter python /usr/local/bin/report-benchmark.py initialize
fi
export OMP_NUM_THREADS=1
output=tmp/latest-$SLURM_JOB_NAME.txt
srun shifter python /usr/local/bin/mpi4py-import.py $(date +%s) | tee $output
if [ $commit = true ]; then
    shifter python /usr/local/bin/report-benchmark.py finalize $( grep elapsed $output | awk '{ print $NF }' )
fi
