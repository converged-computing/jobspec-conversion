#!/bin/bash
#FLUX: --job-name=stanky-signal-6911
#FLUX: --priority=16

GID=$1
POWER=$2
sudo nvidia-smi -ac 1215,1410 -i ${GID}
sudo nvidia-smi -pl ${POWER} -i ${GID}
nvidia-smi -i ${GID} --query-gpu=timestamp,gpu_name,uuid,persistence_mode,pstate,temperature.gpu,temperature.memory,utilization.gpu,utilization.memory,clocks_throttle_reasons.gpu_idle,clocks_throttle_reasons.sw_power_cap,clocks_throttle_reasons.hw_slowdown,clocks_throttle_reasons.hw_thermal_slowdown,clocks_throttle_reasons.hw_power_brake_slowdown,clocks_throttle_reasons.sw_thermal_slowdown,clocks_throttle_reasons.sync_boost,memory.total,memory.free,memory.used,power.draw,power.limit,clocks.current.graphics,clocks.current.sm,clocks.current.memory,clocks.max.graphics,clocks.max.sm,clocks.max.memory,mig.mode.current --format=csv -f metrics_single_${POWER}.csv --loop-ms=100 &
BACK_PID=$!
declare MIG_MODE=( "0" "5" "9" "14" "19" )
declare GI_IDS=( "0" "2" "1" "3" "9")
declare NUM_MODES=( ${#MIG_MODE[@]} )
for (( m=0; m<${NUM_MODES}; m++ ))
do
	echo -e "******************************************************************************************"
	sudo nvidia-smi mig -cgi ${MIG_MODE[${m}]} -i ${GID}
	sudo nvidia-smi mig -cci -gi ${GI_IDS[${m}]} -i ${GID}
	nvidia-smi mig -lgi
	nvidia-smi mig -lci
	MIG_ID="$(nvidia-smi -L | grep -A1 "GPU ${GID}" | grep "MIG" | cut -f3 -d":" | cut -f1 -d"/" | awk '{print $1}')"
	PIDS=()
	for i in "${GI_IDS[${m}]}"
	do
		declare COUNT=(0)
		ID=(`echo $i | sed 's/,/\n/g'`)
		for j in "${ID[@]}"
		do
			CUDA_VISIBLE_DEVICES=${MIG_ID}/${j}/0  ./mig_example ${MIG_MODE[${m}]} ${COUNT} ${MIG_ID}/${j}/0 &
			((COUNT=COUNT+1))
		done
	done
	# -ci 0 because we create single compute instance per gpu instance
	sudo nvidia-smi mig -dci -ci 0 -gi ${GI_IDS[${m}]} -i ${GID}
	sudo nvidia-smi mig -dgi -gi ${GI_IDS[${m}]} -i ${GID}
	sleep 3
	echo -e
done
kill -9 ${BACK_PID}
