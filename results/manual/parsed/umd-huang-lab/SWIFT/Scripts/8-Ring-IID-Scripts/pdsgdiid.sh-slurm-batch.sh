#!/bin/bash
#FLUX: --job-name=PDSGD
#FLUX: -n=8
#FLUX: --queue=scavenger
#FLUX: -t=14400
#FLUX: --urgency=16

module load openmpi
module load cuda/11.1.1
mpirun -np 8 python Train.py  --graph ring --num_clusters 3 --name pdsgd-iid-test1-8W --comm_style pd-sgd --momentum 0.9 --i1 1 --i2 1 --customLR 1 --degree_noniid 0 --noniid 0 --resSize 18 --bs 32 --epoch 200 --description PDSGD --randomSeed 2282 --datasetRoot ./data --outputFolder Output
mpirun -np 8 python Train.py  --graph ring --num_clusters 3 --name pdsgd-iid-test2-8W --comm_style pd-sgd --momentum 0.9 --i1 1 --i2 1 --customLR 1 --degree_noniid 0 --noniid 0 --resSize 18 --bs 32 --epoch 200 --description PDSGD --randomSeed 9867 --datasetRoot ./data --outputFolder Output
mpirun -np 8 python Train.py  --graph ring --num_clusters 3 --name pdsgd-iid-test3-8W --comm_style pd-sgd --momentum 0.9 --i1 1 --i2 1 --customLR 1 --degree_noniid 0 --noniid 0 --resSize 18 --bs 32 --epoch 200 --description PDSGD --randomSeed 6666 --datasetRoot ./data --outputFolder Output
mpirun -np 8 python Train.py  --graph ring --num_clusters 3 --name pdsgd-iid-test4-8W --comm_style pd-sgd --momentum 0.9 --i1 1 --i2 1 --customLR 1 --degree_noniid 0 --noniid 0 --resSize 18 --bs 32 --epoch 200 --description PDSGD --randomSeed 7777 --datasetRoot ./data --outputFolder Output
mpirun -np 8 python Train.py  --graph ring --num_clusters 3 --name pdsgd-iid-test5-8W --comm_style pd-sgd --momentum 0.9 --i1 1 --i2 1 --customLR 1 --degree_noniid 0 --noniid 0 --resSize 18 --bs 32 --epoch 200 --description PDSGD --randomSeed 8888 --datasetRoot ./data --outputFolder Output
