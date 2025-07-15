#!/bin/bash
#FLUX: --job-name=bricky-pedo-5430
#FLUX: --queue=ckpt
#FLUX: -t=172800
#FLUX: --urgency=16

module load cuda
seed=$SLURM_ARRAY_TASK_ID
for i in `seq 1 9`; do
	N=$((10000*i))
	dK=$((2*N/10))
	KS="0 $((dK)) $((2*dK)) $((3*dK)) $((4*dK)) $((5*dK))"
	for K in $KS; do 
	echo $N $K $dK
	mkdir -p data/$N/$K
	if [ $N -lt 40000 ]; then
		./kuramoto -N $N -K $K -s $seed -c 1.75 -t 100 -d 0.01 -nvDR data/$N/$K/$seed > /dev/null
	else
		./kuramoto -N $N -K $K -s $seed -c 1.75 -t 100 -d 0.01 -nvDAR data/$N/$K/$seed > /dev/null
	fi
done
done
