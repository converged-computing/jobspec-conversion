#!/bin/bash
#FLUX: --job-name=frigid-cat-7834
#FLUX: -N=4
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='24'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

cd $SLURM_SUBMIT_DIR   # optional, since this is the default behavior
source $SLURM_SUBMIT_DIR/env.ips.edison
module swap PrgEnv-intel PrgEnv-gnu
module load python/2.7-anaconda
export OMP_NUM_THREADS=24
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
$IPS_PATH/bin/ips.py --config=ips.ftx.config --platform=conf.ips.edison --log=log.framework 2>>log.stdErr 1>>log.stdOut
egrep -i 'error' log.* > log.errors
./setPermissions.sh
