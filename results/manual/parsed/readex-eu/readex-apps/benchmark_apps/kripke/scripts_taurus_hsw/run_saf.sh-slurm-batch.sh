#!/bin/bash
#FLUX: --job-name=READEX-kripke
#FLUX: -n=24
#FLUX: --exclusive
#FLUX: --queue=haswell
#FLUX: -t=7200
#FLUX: --urgency=16

export SCOREP_FILTERING_FILE='scorep.filt'

cd ../build
. ../readex_env/set_env_saf.source
. ../environment.sh
export SCOREP_FILTERING_FILE=scorep.filt
rm -rf scorep-*
rm -f old_scorep.filt
echo "" > scorep.filt
if [ "$READEX_INTEL" == "1" ]; then
  rm -rf old_scorep_icc.filt
  echo "" > scorep_icc.filt
fi
iter=0
result=1
while [ $result != 0 ]; do
  iter=$[ $iter +1 ]
  echo "result = "$result
  # run the application.. update this for different applications
  srun -n 24 ./kripke $KRIPKE_COMMAND
  echo "kripke done."
  ./do_scorep_autofilter_single.sh 0.001 #$1
  result=$?
  echo "scorep_autofilter_singe done ($result)."
done
echo "end." 
