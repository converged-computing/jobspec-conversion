#!/bin/bash
#FLUX: --job-name=delicious-hobbit-4093
#FLUX: -c=10
#FLUX: -t=21600
#FLUX: --priority=16

export TORCH_HOME='$project'

export TORCH_HOME=$project
if [ -z "1" ]; then
    echo "No dataset supplied"
    exit 1
fi
if [ -z "2" ]; then
    echo "No augmentation set supplied"
    exit 1
fi
SAVE_DIR=$scratch/miccai2024/trivial_augment
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
python trivial_augment.py \
    --data_dir $SLURM_TMPDIR/data \
    --config_dir config \
    --log_dir $SAVE_DIR \
    --workers 9 \
    --seed 0 \
    --dataset $1 \
    --subset $2 \
