#!/bin/bash
#FLUX: --job-name=e50p02swwae1lr0001
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load pytorch/intel/20170125
module load torchvision/0.1.7
python mnist_model.py --no-cuda --epochs $1 --saveLocation '/results/model'
python mnist_results.py --no-cuda --savedLocation '/results/model_1.t7' --resultsLocation '/results/sample_submission.csv'
