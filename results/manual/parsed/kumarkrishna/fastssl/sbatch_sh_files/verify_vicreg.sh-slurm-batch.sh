#!/bin/bash
#SBATCH --job-name=verify_vicreg
#SBATCH --output=sbatch_out/verify_vicreg.out
#SBATCH --error=sbatch_err/verify_vicreg.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --mem=16GB
#SBATCH --time=04:00:00

. /etc/profile
module load anaconda/3
conda activate ffcv_new
lambd=25.0
mu=25.0
pdim=2048
dataset='cifar10'
if [ $dataset = 'stl10' ]
then
    batch_size=256
else
    batch_size=512
fi
checkpt_dir=$SCRATCH/fastssl/checkpoints
train_dpath=$SCRATCH/ffcv/ffcv_datasets/{dataset}/train.beton
val_dpath=$SCRATCH/ffcv/ffcv_datasets/{dataset}/test.beton
model=resnet50proj
python scripts/train_model.py --config-file configs/cc_VICReg.yaml \
                --training.model=$model --training.dataset=$dataset \
                --training.lambd=$lambd --training.mu=$mu \
                --training.projector_dim=$pdim  --training.ckpt_dir=$checkpt_dir \
                --training.batch_size=$batch_size \
                --training.train_dataset=$train_dpath --training.val_dataset=$val_dpath
cp $SLURM_TMPDIR/*.pth $checkpt_dir/resnet50_checkpoints/
model=resnet50feat
python scripts/train_model.py --config-file configs/cc_precache.yaml \
                --eval.train_algorithm='VICReg' \
                --training.model=$model --training.dataset=$dataset \
                --training.lambd=$lambd --training.mu=$mu \
                --training.projector_dim=$pdim --training.ckpt_dir=$checkpt_dir \
                --training.batch_size=$batch_size \
                --training.train_dataset=$train_dpath --training.val_dataset=$val_dpath
python scripts/train_model.py --config-file configs/cc_classifier.yaml \
                --eval.train_algorithm='VICReg' \
                --training.model=$model --training.dataset=$dataset \
                --training.lambd=$lambd --training.mu=$mu \
                --training.projector_dim=$pdim --training.ckpt_dir=$checkpt_dir \
                --training.seed=42 \
                --training.train_dataset=$train_dpath --training.val_dataset=$val_dpath
