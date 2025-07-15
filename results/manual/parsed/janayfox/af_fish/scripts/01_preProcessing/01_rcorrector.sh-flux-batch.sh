#!/bin/bash
#FLUX: --job-name=nerdy-dog-0665
#FLUX: -c=16
#FLUX: -t=432000
#FLUX: --priority=16

module load rcorrector
perl /cvmfs/soft.computecanada.ca/easybuild/software/2020/avx512/Core/rcorrector/1.0.4/bin/run_rcorrector.pl -t 12 -1 $1 -2 $2 -od /home/janayfox/scratch/afFishRNA/rcorrector_output
