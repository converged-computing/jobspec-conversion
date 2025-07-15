#!/bin/bash
#FLUX: --job-name=expressive-poo-8338
#FLUX: -N=8
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --priority=16

export PYTHONPATH='$SLURM_SUBMIT_DIR:$PYTHONPATH'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

cd $SLURM_SUBMIT_DIR   # optional, since this is the default behavior
source $SLURM_SUBMIT_DIR/env.ips.cori #.python3
source $SLURM_SUBMIT_DIR/env.GITR.cori.AL.sh
export PYTHONPATH=$SLURM_SUBMIT_DIR:$PYTHONPATH
module load python/3.7-anaconda-2019.07
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
$IPS_PATH/bin/ips.py --config=ips.parent.conf --platform=conf.ips.cori --log=log.framework 2>>log.stdErr 1>>log.stdOut
egrep -i 'error' log.* > log.errors
./setPermissions.sh
