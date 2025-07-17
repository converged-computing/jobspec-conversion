#!/bin/bash
#FLUX: --job-name=term-project
#FLUX: --queue=gpu
#FLUX: -t=300
#FLUX: --urgency=16

module load cuda
module load gcc
cd /home/qifwang/eecs587/term-project/build
rm -rf *
cmake ..
make
cd /home/qifwang/eecs587/term-project/build
rm ../output.txt
./scheduler > ../output.txt
