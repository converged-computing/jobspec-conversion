#!/bin/bash
#SBATCH --job-name=CBISresnet_mammo
#SBATCH --account=sq58
#SBATCH --output=./sbatchlog/resnet/CBISresnet_mammo-%j.out
#SBATCH --error=./sbatchlog/resnet/CBISresnet_mammo-%j.err
#SBATCH --mail-user=enoch.mok@monash.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:V100:1
#SBATCH --mem=16000
#SBATCH --time=2-23:00:00
#SBATCH --constraint=ntasks-per-node=1

EPOCHS="$1"
DATA_AUG="$2"
eval "$(conda shell.bash hook)"
conda activate exp1
if [ "$DATA_AUG" == "true" ]; then
    echo "Running script with data augmentation"
    srun --exclusive python main.py --model resnet50 --dataset CBIS-DDSM --num_epochs $EPOCHS --data_augment --early_stopping
else
    echo "Running script without data augmentation"
    srun --exclusive python main.py --model resnet50 --dataset CBIS-DDSM --num_epochs $EPOCHS --no-data_augment
fi
