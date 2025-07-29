#!/bin/bash
#SBATCH --job-name=cori-pynamic-150-shifter
#SBATCH --account=mpccc
#SBATCH --output=logs/slurm-cori-pynamic-150-shifter-%j.out
#SBATCH --mail-user=rcthomas@lbl.gov
#SBATCH --mail-type=FAIL
#SBATCH --nodes=150
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:25:00
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=32

export PMI_MMAP_SYNC_WAIT_TIME='300'

singularity
exec
docker:registry.services.nersc.gov/pynamic:2.6a1
commit=true
debug=false
if [ $debug = true ]; then
    module list
    set -x
fi
unset PYTHONSTARTUP
unset PYTHONPATH
unset LD_LIBRARY_PATH
unset CRAY_LD_LIBRARY_PATH
unset LIBRARY_PATH
export PMI_MMAP_SYNC_WAIT_TIME=300
if [ $commit = true ]; then
    module unload python
    module unload altd
    module swap PrgEnv-intel PrgEnv-gnu
    module load python_base
    module load mysql
    module load mysqlpython
    python report-benchmark.py initialize
    module unload mysqlpython
    module unload python_base
fi
output=latest-$SLURM_JOB_NAME.txt
module load shifter
srun shifter /bench/pynamic-pyMPI /bench/pynamic_driver.py $(date +%s) | tee $output
startup_time=$( grep '^Pynamic: startup time' $output | awk '{ print $(NF-1) }' )
import_time=$( grep '^Pynamic: module import time' $output | awk '{ print $(NF-1) }' )
visit_time=$( grep '^Pynamic: module visit time' $output | awk '{ print $(NF-1) }' )
total_time=$( echo $startup_time + $import_time + $visit_time | bc )
if [ $commit = true ]; then
    module load python_base
    module load mysqlpython
    python report-benchmark.py finalize $total_time
fi
