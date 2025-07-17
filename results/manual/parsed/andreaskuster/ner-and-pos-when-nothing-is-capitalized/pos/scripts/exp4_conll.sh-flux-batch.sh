#!/bin/bash
#FLUX: --job-name=gassy-leopard-6222
#FLUX: -c=128
#FLUX: --queue=amdv100
#FLUX: -t=14400
#FLUX: --urgency=16

module load python/3.7.2
module load CMake
module load GCC
source ~/.bashrc
conda activate dev
cd ~/uw-nlp && python3 pos/pos.py --model BILSTM_CRF --dataset CONLL2000 --traincasetype CASED --devcasetype CASED --testcasetype TRUECASE --embedding ELMO --batchsize 1024 --epochs 40 --learningrate 1e-3 --lstmhiddenunits 512 --lstmdropout 0.0 --lstmrecdropout 0.0 --numgpus 2
