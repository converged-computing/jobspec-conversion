#!/bin/bash
#FLUX: --job-name=dinosaur-platanos-4282
#FLUX: -t=172800
#FLUX: --priority=16

for trial in 1 2 3 4 5
do
	python train_ext.py \
	--dataset regdb  \
	--method adp \
	--augc 1 \
	--rande 0.5 \
	--alpha 1 \
	--square 1 \
	--gamma 1 \
	--trial $trial
done
echo 'Done!'
