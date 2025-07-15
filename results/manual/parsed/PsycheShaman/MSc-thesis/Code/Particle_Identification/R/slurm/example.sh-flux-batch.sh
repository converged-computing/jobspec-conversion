#!/bin/bash
#FLUX: --job-name=MyJob
#FLUX: -n=2
#FLUX: --queue=ada
#FLUX: -t=36000
#FLUX: --urgency=16

module load software/TensorFlow-CPU-py3 
module load python/TensorAnaconda
module load software/R-3.5.1
module load python/anaconda-python-3.7 
Rscript /home/vljchr004/myscript.R /scratch/vljchr004/x_265377 /scratch/vljchr004/y_265377
