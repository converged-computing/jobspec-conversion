#!/bin/bash
#FLUX: --job-name=ornery-train-7656
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: --queue=haswell
#FLUX: -t=36000
#FLUX: --urgency=16

export MERIC_MODE='2'
export MERIC_DEBUG='0'
export MERIC_CONTINUAL='1'
export MERIC_AGGREGATE='1'
export MERIC_DETAILED='0'
export MERIC_NUM_THREADS='24'
export MERIC_FREQUENCY='25'
export MERIC_UNCORE_FREQUENCY='30'
export MERIC_OUTPUT_DIR='lulesh_meric_dir'

cd ..
module purge
source ./readex_env/set_env_meric.source
export MERIC_MODE=2
export MERIC_DEBUG=0
export MERIC_CONTINUAL=1
export MERIC_AGGREGATE=1
export MERIC_DETAILED=0
export MERIC_NUM_THREADS=24
export MERIC_FREQUENCY=25
export MERIC_UNCORE_FREQUENCY=30
export MERIC_OUTPUT_DIR="lulesh_meric_dir"
srun ./lulesh2.0_meric -i 75 -s 150
rm -rf $MERIC_OUTPUT_DIR
rm -rf ${MERIC_OUTPUT_DIR}Counters
echo $MERIC_OUTPUT_DIR
for thread in {24..4..-4}
do
  for cpu_freq in {25..14..-4}
  do
    for uncore_freq in {30..14..-4}
    do
      export MERIC_OUTPUT_FILENAME=$thread"_"$cpu_freq"_"$uncore_freq
      export MERIC_NUM_THREADS=$thread
      export MERIC_FREQUENCY=$cpu_freq
      export MERIC_UNCORE_FREQUENCY=$uncore_freq
      echo
      echo TEST $MERIC_OUTPUT_FILENAME
      for repeat in {1..1..1}
      do
        ret=1
        while [ "$ret" -ne 0 ]
        do
		  srun ./lulesh2.0_meric -i 75 -s 150 
		  ret=$?
        done
      done 
    done
  done
done
