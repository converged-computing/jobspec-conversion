#!/bin/bash
#FLUX: --job-name=astute-puppy-6883
#FLUX: --queue=amdv100
#FLUX: --urgency=16

module load python/3.7.2
module load CMake
module load GCC
source ~/.bashrc
conda activate dev
cd ~/uw-nlp && python3 pos/pos.py --model BILSTM_CRF --dataset PTB --traincasetype CASED_UNCASED --devcasetype CASED_UNCASED --testcasetype CASED --embedding GLOVE --batchsize 1024 --epochs 40 --learningrate 1e-3 --lstmhiddenunits 512 --lstmdropout 0.0 --lstmrecdropout 0.0 --numgpus 2
