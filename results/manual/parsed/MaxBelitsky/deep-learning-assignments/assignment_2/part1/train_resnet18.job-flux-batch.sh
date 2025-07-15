#!/bin/bash
#FLUX: --job-name=TrainResnet18
#FLUX: -c=18
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --urgency=16

module purge
module load 2022
module load Anaconda3/2022.05
source activate dl2023
cd $HOME/deep-learning-assignments/assignment_2/part1/
echo "Running experiment without the augmentation"
srun python train.py --checkpoint_name ./save/models/fine-tuned-resnet18 --data_dir $TMPDIR/data/
augmentations=("flip" "resize")
for augmentation in "${augmentations[@]}"; do
    echo "Running experiment with the augmentation: $augmentation"
    srun python train.py --checkpoint_name ./save/models/fine-tuned-resnet18-$augmentation --data_dir $TMPDIR/data/ --augmentation_name $augmentation
done
