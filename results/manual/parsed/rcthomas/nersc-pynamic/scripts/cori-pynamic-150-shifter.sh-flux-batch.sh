#!/bin/bash
#FLUX: --job-name=cori-pynamic-150-shifter
#FLUX: -N=150
#FLUX: --queue=regular
#FLUX: -t=1500
#FLUX: --urgency=16

export PMI_MMAP_SYNC_WAIT_TIME='300'

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
