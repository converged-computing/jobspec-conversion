#!/bin/bash
#SBATCH --job-name=gpujob
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:0
#SBATCH --mem=4G
#SBATCH --time=20:00:00
#SBATCH --partition=g
#SBATCH --qos=long

singularity run --nv /cvmfs/unpacked.cern.ch/registry.hub.docker.com/cernml4reco/deepjetcore3:latest /users/maximilian.moser/DeepLeptonStuff/DeepLepton-Training/convert.sh
echo "done"
