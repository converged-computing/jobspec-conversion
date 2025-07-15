#!/bin/bash
#FLUX: --job-name=reclusive-eagle-2293
#FLUX: --queue=gpu
#FLUX: -t=216000
#FLUX: --urgency=16

source ~/miniconda3/etc/profile.d/conda.sh
conda activate rs_3.8
echo Start
model=("resnet_base")
loss=("asl")
optim=("sgd")
learning_rates=(0.001)
noises=(0.1 0.3 0.5 0.7)
for m in ${model[@]}; do
	for l in ${loss[@]}; do
		for o in ${optim[@]}; do
				for lr in ${learning_rates[@]}; do
				  no_noise="-model ${m} -loss ${l} -optim ${o} -lr ${lr}"
            python3 src/main.py $no_noise
						for n in ${noises[@]}; do
              add_noise="-model ${m} -loss ${l} -optim ${o} -lr ${lr} -add_noise ${n}"
              python3 src/main.py $add_noise
              sub_noise="-model ${m} -loss ${l} -optim ${o} -lr ${lr} -sub_noise ${n}"
              python3 src/main.py $sub_noise
              balanced="-model ${m} -loss ${l} -optim ${o} -lr ${lr} -add_noise ${n} -sub_noise ${n}"
              python3 src/main.py $balanced
          done
			done
		done
	done
done
