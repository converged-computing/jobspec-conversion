#!/bin/bash
#FLUX: --job-name=nf2_analytic
#FLUX: --queue=gpu
#FLUX: -t=43200
#FLUX: --urgency=16

module load python/pytorch-1.6.0
cd /beegfs/home/robert.jarolim/projects/pub_NF2
python3 -m nf2.train.extrapolate_analytic --config config/multi_height/4tau.json
