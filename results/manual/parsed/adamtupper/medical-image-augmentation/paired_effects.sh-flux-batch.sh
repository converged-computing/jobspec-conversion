#!/bin/bash
#FLUX: --job-name=grated-salad-8399
#FLUX: -c=10
#FLUX: -t=18000
#FLUX: --urgency=16

export TORCH_HOME='$project'

export TORCH_HOME=$project
if [ -z "1" ]; then
    echo "No dataset supplied"
    exit 1
fi
SAVE_DIR=$scratch/miccai2024/paired_effects
echo "Current working directory: `pwd`"
echo "Starting run at: `date`"
echo ""
echo "Job ID: $SLURM_JOB_ID"
echo ""
module purge
mkdir -p $SLURM_TMPDIR/data/
tar -xf $project/data/miccai24/$1.tar.gz -C $SLURM_TMPDIR/data
cp -r $project/BUDA $SLURM_TMPDIR
cd $SLURM_TMPDIR/BUDA
module load python/3.11 cuda cudnn rust
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install --no-index -r cc_requirements.txt
python paired_effects.py \
    --data_dir $SLURM_TMPDIR/data \
    --config_dir config \
    --log_dir $SAVE_DIR \
    --workers 9 \
    --seed 0 \
    --dataset $1 \
