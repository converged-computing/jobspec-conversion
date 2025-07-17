#!/bin/bash
#FLUX: --job-name=misunderstood-cherry-0710
#FLUX: -N=10
#FLUX: --exclusive
#FLUX: --queue=bii
#FLUX: -t=7200
#FLUX: --urgency=16

export RADICAL_LOG_LVL='DEBUG'
export RADICAL_PROFILE='TRUE'
export RADICAL_PILOT_DBURL='mongodb://rct-tutorial:HXH7vExF7GvCeMWn@95.217.193.116:27017/rct-tutorial'

module load gcc/9.2.0 openmpi/3.1.6 cmake/3.23.3 python/3.7.7
source $HOME/cylon_rp_venv/bin/activate
export RADICAL_LOG_LVL="DEBUG"
export RADICAL_PROFILE="TRUE"
export RADICAL_PILOT_DBURL="mongodb://rct-tutorial:HXH7vExF7GvCeMWn@95.217.193.116:27017/rct-tutorial"
python rivanna/rp-scripts/rp_scaling.py
