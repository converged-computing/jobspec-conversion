#!/bin/bash
#FLUX: --job-name=pico-calibration
#FLUX: --priority=16

export PYTHONPATH=''

set -o errexit
nodes=80
nprocs=$(($nodes * 16))
if [ "$INI_FILE" == "" ]; then
    echo "You forgot to set the INI_FILE variable!"
    exit 1
fi
calibrate=$(which calibrate.py)
echo "Starting the script on $(date), directory is $(pwd)"
module swap PrgEnv-intel PrgEnv-gnu
module unload altd
module unload darshan
export PYTHONPATH=
module load python/3.6-anaconda-4.4
echo "Python executable: $(which python)"
echo "Python version: $(python --version &> /dev/stdout)"
echo "Calibrate script: ${calibrate}"
echo "----------------------------------------"
env | sort -d
echo "----------------------------------------"
logfile=./log/$(basename $INI_FILE .ini).log
echo "Going to run srun on $(date) with $nodes nodes"
srun -n $nprocs python ${calibrate} $INI_FILE 2>&1 | tee $logfile
echo "Script ended on $(date)"
