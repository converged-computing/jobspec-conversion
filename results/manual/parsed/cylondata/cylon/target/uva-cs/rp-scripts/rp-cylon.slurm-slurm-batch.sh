#!/bin/bash
#SBATCH --account=bii_dsc_community
#SBATCH --output=rivanna/scripts/cylogs/rp-cylon-3n-40w-5m-%x-%j.out
#SBATCH --error=rivanna/scripts/cylogs/rp-cylon-3n-40w-5m-%x-%j.err
#SBATCH --nodes=10
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=bii
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=40

export RADICAL_LOG_LVL='DEBUG'
export RADICAL_PROFILE='TRUE'
export RADICAL_PILOT_DBURL='mongodb://rct-tutorial:HXH7vExF7GvCeMWn@95.217.193.116:27017/rct-tutorial'

module load gcc/9.2.0 openmpi/3.1.6 cmake/3.23.3 python/3.7.7
source $HOME/cylon_rp_venv/bin/activate
export RADICAL_LOG_LVL="DEBUG"
export RADICAL_PROFILE="TRUE"
export RADICAL_PILOT_DBURL="mongodb://rct-tutorial:HXH7vExF7GvCeMWn@95.217.193.116:27017/rct-tutorial"
python rivanna/rp-scripts/rp_scaling.py
