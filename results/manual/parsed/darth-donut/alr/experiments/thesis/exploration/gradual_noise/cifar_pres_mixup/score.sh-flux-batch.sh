#!/bin/bash
#FLUX: --job-name="pmix-score"
#FLUX: -c=4
#FLUX: --queue=msc
#FLUX: --priority=16

export TMPDIR='/scratch-ssd/${USER}/tmp'
export CONDA_ENVS_PATH='/scratch-ssd/$USER/conda_envs'
export CONDA_PKGS_DIRS='/scratch-ssd/$USER/conda_pkgs'

export TMPDIR=/scratch-ssd/${USER}/tmp
mkdir -p $TMPDIR
export CONDA_ENVS_PATH=/scratch-ssd/$USER/conda_envs
export CONDA_PKGS_DIRS=/scratch-ssd/$USER/conda_pkgs
/scratch-ssd/oatml/scripts/run_locked.sh /scratch-ssd/oatml/miniconda3/bin/conda-env update -f environment.yml
source /scratch-ssd/oatml/miniconda3/bin/activate ml3
START=$(date +%s.%N)
srun python score.py
END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)
echo "run time: $DIFF secs"
