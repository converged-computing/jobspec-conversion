#!/bin/bash
#FLUX: --job-name=nerdy-car-5781
#FLUX: --queue=debug
#FLUX: -t=180
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR   # optional, since this is the default behavior
source /project/projectdirs/atom/users/tyounkin/ips-examples/ftridyn_ea_task_pool/env.ips.edison
$IPS_PATH/bin/ips.py --config=ips.config --platform=conf.ips.edison --log=log.framework 2>>log.stdErr 1>>log.stdOut
egrep -i 'error' log.* > log.errors
./setPermissions.sh
