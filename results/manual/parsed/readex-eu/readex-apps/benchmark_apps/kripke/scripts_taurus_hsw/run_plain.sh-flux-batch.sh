#!/bin/bash
#FLUX: --job-name=salted-cat-2099
#FLUX: --exclusive
#FLUX: --queue=haswell
#FLUX: -t=1800
#FLUX: --urgency=16

cd ../build
. ../readex_env/set_env_plain.source
. ../environment.sh
stopHdeem
clearHdeem
startHdeem
sleep 1
stopHdeem
echo "running kripke"
clearHdeem
startHdeem
srun -n 24 ./kripke $KRIPKE_COMMAND
stopHdeem
sleep 1
checkHdeem
echo "running kripke done"
