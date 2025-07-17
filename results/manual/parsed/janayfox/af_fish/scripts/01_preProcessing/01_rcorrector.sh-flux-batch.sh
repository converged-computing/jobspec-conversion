#!/bin/bash
#FLUX: --job-name=delicious-poodle-5479
#FLUX: -c=16
#FLUX: -t=432000
#FLUX: --urgency=16

module load rcorrector
perl /cvmfs/soft.computecanada.ca/easybuild/software/2020/avx512/Core/rcorrector/1.0.4/bin/run_rcorrector.pl -t 12 -1 $1 -2 $2 -od /home/janayfox/scratch/afFishRNA/rcorrector_output
