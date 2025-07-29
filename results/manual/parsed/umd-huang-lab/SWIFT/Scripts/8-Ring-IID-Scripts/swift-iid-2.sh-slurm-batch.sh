#!/bin/bash
#SBATCH --job-name=SWIFT
#SBATCH --account=scavenger
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem-per-cpu=64gb
#SBATCH --time=04:00:00
#SBATCH --partition=scavenger
#SBATCH --qos=normal

module load openmpi
module load cuda/11.1.1
mpirun -np 8 python Train.py --name swift-iid-test1-8W-no_mem --graph ring --customLR 1 --sgd_steps 2 --weight_type swift --momentum 0.9 --degree_noniid 0 --noniid 0 --resSize 18 --bs 32 --epoch 200 --wb 1 --description SWIFT --randomSeed 3782 --datasetRoot ./data --outputFolder Output
mpirun -np 8 python Train.py --name swift-iid-test2-8W-no_mem --graph ring --customLR 1 --sgd_steps 2 --weight_type swift --momentum 0.9 --degree_noniid 0 --noniid 0 --resSize 18 --bs 32 --epoch 200 --wb 1 --description SWIFT --randomSeed 24 --datasetRoot ./data --outputFolder Output
mpirun -np 8 python Train.py --name swift-iid-test3-8W-no_mem --graph ring --customLR 1 --sgd_steps 2 --weight_type swift --momentum 0.9 --degree_noniid 0 --noniid 0 --resSize 18 --bs 32 --epoch 200 --wb 1 --description SWIFT --randomSeed 332 --datasetRoot ./data --outputFolder Output
mpirun -np 8 python Train.py --name swift-iid-test4-8W-no_mem --graph ring --customLR 1 --sgd_steps 2 --weight_type swift --momentum 0.9 --degree_noniid 0 --noniid 0 --resSize 18 --bs 32 --epoch 200 --wb 1 --description SWIFT --randomSeed 1221 --datasetRoot ./data --outputFolder Output
mpirun -np 8 python Train.py --name swift-iid-test5-8W-no_mem --graph ring --customLR 1 --sgd_steps 2 --weight_type swift --momentum 0.9 --degree_noniid 0 --noniid 0 --resSize 18 --bs 32 --epoch 200 --wb 1 --description SWIFT --randomSeed 1331 --datasetRoot ./data --outputFolder Output
