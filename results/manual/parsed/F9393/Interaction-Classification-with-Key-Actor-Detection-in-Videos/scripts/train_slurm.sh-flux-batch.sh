#!/bin/bash
#FLUX: --job-name=expensive-peas-0486
#FLUX: -N=2
#FLUX: -c=4
#FLUX: -t=1200
#FLUX: --urgency=16

module load python/3.8.10
module load gcc/8.4.0
module load cuda/10.2
module load cudacore/.11.1.1
module load cudnn/8.2.0
source /home/user_account/pytorch/bin/activate
srun --ntasks=$SLURM_NNODES --ntasks-per-node=1 unzip -qq /home/user_account/projects/def-account/user_account/sbu_dataset.zip -d $SLURM_TMPDIR/sbu_dataset
srun python /home/user_account/scratch/Key-Actor-Detection/run.py /home/user_account/scratch/Key-Actor-Detection/configs/sbu.yaml "dataset_path=$SLURM_TMPDIR/sbu_dataset" "training.save_dir=$SLURM_TMPDIR/mlruns" "caching.folds_cache_path=$SLURM_TMPDIR/sbu_dataset/folds_cache"
cp -r $SLURM_TMPDIR/mlruns /home/user_account/scratch
