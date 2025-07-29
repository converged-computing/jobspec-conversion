#!/bin/bash
#FLUX: --job-name=SWIFT
#FLUX: -n=8
#FLUX: --queue=scavenger
#FLUX: -t=14400
#FLUX: --urgency=16

module load openmpi
module load cuda/11.1.1
mpirun -np 8 python Train.py --name swift-iid-test1-8W-no_mem --graph ring --customLR 1 --sgd_steps 2 --weight_type swift --momentum 0.9 --degree_noniid 0 --noniid 0 --resSize 18 --bs 32 --epoch 200 --wb 1 --description SWIFT --randomSeed 3782 --datasetRoot ./data --outputFolder Output
mpirun -np 8 python Train.py --name swift-iid-test2-8W-no_mem --graph ring --customLR 1 --sgd_steps 2 --weight_type swift --momentum 0.9 --degree_noniid 0 --noniid 0 --resSize 18 --bs 32 --epoch 200 --wb 1 --description SWIFT --randomSeed 24 --datasetRoot ./data --outputFolder Output
mpirun -np 8 python Train.py --name swift-iid-test3-8W-no_mem --graph ring --customLR 1 --sgd_steps 2 --weight_type swift --momentum 0.9 --degree_noniid 0 --noniid 0 --resSize 18 --bs 32 --epoch 200 --wb 1 --description SWIFT --randomSeed 332 --datasetRoot ./data --outputFolder Output
mpirun -np 8 python Train.py --name swift-iid-test4-8W-no_mem --graph ring --customLR 1 --sgd_steps 2 --weight_type swift --momentum 0.9 --degree_noniid 0 --noniid 0 --resSize 18 --bs 32 --epoch 200 --wb 1 --description SWIFT --randomSeed 1221 --datasetRoot ./data --outputFolder Output
mpirun -np 8 python Train.py --name swift-iid-test5-8W-no_mem --graph ring --customLR 1 --sgd_steps 2 --weight_type swift --momentum 0.9 --degree_noniid 0 --noniid 0 --resSize 18 --bs 32 --epoch 200 --wb 1 --description SWIFT --randomSeed 1331 --datasetRoot ./data --outputFolder Output
