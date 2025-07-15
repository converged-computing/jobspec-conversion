#!/bin/bash
#FLUX: --job-name=muffled-bits-1065
#FLUX: --exclusive
#FLUX: --queue=broadwell
#FLUX: --priority=16

export MERIC_MODE='1'
export MERIC_COUNTERS='perfevent'
export MERIC_CONTINUAL='1'
export MERIC_DETAILED='1'
export MERIC_OUTPUT_DIR='$SCRATCH/KRIPKEiccBDW'
export MERIC_FREQUENCY='24'
export MERIC_UNCORE_FREQUENCY='25'
export MERIC_NUM_THREADS='0'
export MERIC_OUTPUT_FILENAME='$MERIC_FREQUENCY"_"$MERIC_UNCORE_FREQUENCY"_CONFIG'

hostname
cd ../build
. ../readex_env/set_env_meric.source
. ../environment.sh
export MERIC_MODE=1
export MERIC_COUNTERS=perfevent
export MERIC_CONTINUAL=1
export MERIC_DETAILED=1
export MERIC_OUTPUT_DIR=$SCRATCH/DELETE
export MERIC_FREQUENCY=24
export MERIC_UNCORE_FREQUENCY=25
export MERIC_NUM_THREADS=0
export MERIC_OUTPUT_FILENAME=$MERIC_FREQUENCY"_"$MERIC_UNCORE_FREQUENCY"_CONFIG"
srun -n 28 ./kripke $KRIPKE_COMMAND
export MERIC_OUTPUT_DIR=$SCRATCH/KRIPKEiccBDW
for proc in 28
do
	for thread in 0
	do
		for cpu_freq in {24..12..2} 
		do
			for uncore_freq in 27 {26..12..2} 
			do
				# OUTPUT NAMES
				export MERIC_OUTPUT_FILENAME=$cpu_freq"_"$uncore_freq"_CONFIG"
				# TEST SETTINGS
				export MERIC_FREQUENCY=$cpu_freq
				export MERIC_UNCORE_FREQUENCY=$uncore_freq
				echo "Output file: "  $MERIC_OUTPUT_FILENAME
				echo 
				ret=1
				while [ "$ret" -ne 0 ]
				do
					srun -n 28 ./kripke $KRIPKE_COMMAND | tee -a LOGmeric
					ret=$?
				done
			done
		done
	done
done
