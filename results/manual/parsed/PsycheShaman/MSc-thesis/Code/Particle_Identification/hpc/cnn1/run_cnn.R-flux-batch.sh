#!/bin/bash
#FLUX: --job-name=MyJob
#FLUX: -n=2
#FLUX: --queue=ada
#FLUX: -t=36000
#FLUX: --urgency=16

module load software/R-3.5.2
module load python/anaconda-python-3.7 
module load software/TensorFlow-CPU-py3
module load python/TensorAnaconda 
Rscript cnn.R /scratch/vljchr00/data/train
