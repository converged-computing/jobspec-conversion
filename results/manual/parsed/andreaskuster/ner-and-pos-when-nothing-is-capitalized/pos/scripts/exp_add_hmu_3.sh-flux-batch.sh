#!/bin/bash
#FLUX: --job-name=milky-hobbit-4169
#FLUX: --queue=amdv100
#FLUX: --priority=16

module load python/3.7.2
module load CMake
module load GCC
source ~/.bashrc
conda activate dev
cd ~/uw-nlp && python3 pos/pos.py --model BILSTM --dataset PTB --traincasetype HALF_MIXED --devcasetype HALF_MIXED --testcasetype UNCASED --embedding ELMO --batchsize 1024 --epochs 40 --learningrate 1e-3 --lstmhiddenunits 512 --lstmdropout 0.0 --lstmrecdropout 0.0 --numgpus 2
