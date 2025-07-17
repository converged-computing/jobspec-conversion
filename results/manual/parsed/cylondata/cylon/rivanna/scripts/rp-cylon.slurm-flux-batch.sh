#!/bin/bash
#FLUX: --job-name=ornery-malarkey-1610
#FLUX: -N=2
#FLUX: --queue=parallel
#FLUX: -t=1200
#FLUX: --urgency=16

export RADICAL_LOG_LVL='DEBUG'
export RADICAL_PROFILE='TRUE'
export RADICAL_PILOT_DBURL='mongodb://rct-tutorial:HXH7vExF7GvCeMWn@95.217.193.116:27017/rct-tutorial'
export LD_LIBRARY_PATH='$HOME/rc_arup/cylon/build/arrow/install/lib64:$HOME/rc_arup/cylon/build/glog/install/lib64:$HOME/rc_arup/cylon/build/lib64:$HOME/rc_arup/cylon/build/lib:$LD_LIBRARY_PATH'

module load gcc/9.2.0 openmpi/3.1.6 cmake/3.23.3 python/3.7.7
source /project/bii_dsc_community/djy8hg/cylon_rp_venv/bin/activate
export RADICAL_LOG_LVL="DEBUG"
export RADICAL_PROFILE="TRUE"
export RADICAL_PILOT_DBURL="mongodb://rct-tutorial:HXH7vExF7GvCeMWn@95.217.193.116:27017/rct-tutorial"
export LD_LIBRARY_PATH=$HOME/rc_arup/cylon/build/arrow/install/lib64:$HOME/rc_arup/cylon/build/glog/install/lib64:$HOME/rc_arup/cylon/build/lib64:$HOME/rc_arup/cylon/build/lib:$LD_LIBRARY_PATH
python groupby.py
