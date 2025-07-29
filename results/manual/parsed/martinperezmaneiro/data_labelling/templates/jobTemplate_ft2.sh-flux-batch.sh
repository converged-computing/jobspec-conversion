#!/bin/bash
#FLUX: --job-name={jobname}
#FLUX: --queue=shared
#FLUX: --urgency=16

start=`date +%s`
source $STORE/ic_setup.sh
source $HOME/data_labelling/setup.sh
pwd
{commands} #aqui iran los comandos a correr, tipo city beersheba beersheba.conf
end=`date +%s`
let deltatime=end-start
let hours=deltatime/3600
let minutes=(deltatime/60)%60
let seconds=deltatime%60
printf "Time spent: %d:%02d:%02d\n" $hours $minutes $seconds
