#!/bin/bash
#FLUX: --job-name=opt
#FLUX: --queue=a100
#FLUX: --priority=16

module load mpich-4.0.2-gcc-4.8.5-kaz3kvk 
module load cmake-3.24.2-gcc-4.8.5-idyies2
module load cuda/11.3
./test /share/home/wanghongyu/Courses/UCAS-GPU/hw11/
