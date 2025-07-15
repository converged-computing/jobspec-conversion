#!/bin/bash
#FLUX: --job-name="mini_bh_prelim"
#FLUX: -c=4
#FLUX: --queue=svl --qos=normal
#FLUX: -t=43200
#FLUX: --priority=16

export LD_LIBRARY_PATH='/usr/local/cuda-9.1/lib64:/usr/lib/x86_64-linux-gnu'

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory = "$SLURM_SUBMIT_DIR
module load anaconda3
source activate behavior
echo "conda env activated"
export LD_LIBRARY_PATH=/usr/local/cuda-9.1/lib64:/usr/lib/x86_64-linux-gnu
echo "Working with the LD_LIBRARY_PATH: "$LD_LIBRARY_PATH
cd /vision/u/emilyjin/mini_behavior/
echo "running command: python train_rl_agent.py --task InstallingAPrinter"
python train_rl_agent.py --task InstallingAPrinter
echo "running command: python train_rl_agent.py --task PuttingAwayDishesAfterCleaning"
python train_rl_agent.py --task PuttingAwayDishesAfterCleaning
echo "running command: python train_rl_agent.py --task WashingPotsAndPans"
python train_rl_agent.py --task WashingPotsAndPans
echo "Done"
