#!/bin/bash
#FLUX: --job-name=persnickety-onion-4312
#FLUX: --queue=ckpt
#FLUX: -t=172800
#FLUX: --urgency=16

module load cuda
seed=$SLURM_ARRAY_TASK_ID
for i in `seq 1 1`; do
	N=$((5000*i))
	KS="0 2 $((5000*i))"
	for K in $KS; do 
	echo $N $K $dK
	mkdir -p data/$N/$K
	mkdir -p data/${N}_lorentz/$K
	./kuramoto -N $N -K $K -s $seed -c 1.75 -t 100 -d 0.01 -nvDR data/$N/$K/$seed > /dev/null
	./kuramoto -N $N -K $K -s $seed -c 1.75 -t 100 -d 0.01 -vDR data/${N}_lorentz/$K/$seed > /dev/null
done
done
