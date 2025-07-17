#!/bin/bash
#FLUX: --job-name=bricky-sundae-5027
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR   # optional, since this is the default behavior
source /project/projectdirs/atom/users/tyounkin/ips-examples/ftridyn/env.ips.edison
$IPS_PATH/bin/ips.py --config=ips.config --platform=conf.ips.edison --log=log.framework 2>>log.stdErr 1>>log.stdOut
egrep -i 'error' log.* > log.errors
./setPermissions.sh
