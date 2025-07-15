#!/bin/bash
#FLUX: --job-name=toadgan
#FLUX: -n=5
#FLUX: -c=2
#FLUX: --queue=gpu_cluster_enife
#FLUX: -t=172800
#FLUX: --priority=16

cd /home/schubert/projects/TOAD-GAN
source /home/schubert/miniconda3/tmp/bin/activate toadgan
for file in input/*.txt
do
    srun --ntasks 1 --gres=gpu:1 python main.py --scales 0.9 0.7 0.5 --input_dir input --input_name $(basename -- $file) --num_layer 3  --niter 6000 --nfc 64 &
done
wait
RUN_DIR=./tmp/$SLURM_JOBID
mkdir -p $RUN_DIR/runs
mv wandb/*run-* $RUN_DIR/runs/
srun -n 1 python main_tile_pattern.py --level-dir input --run-dir $RUN_DIR/runs
mkdir -p $RUN_DIR/results
mv wandb/*run-* $RUN_DIR/results/
srun -n 1 python main_level_classification.py --level-dir input
mkdir -p $RUN_DIR/classifier
mv wandb/*run-* $RUN_DIR/classifier/
srun -n 1 python main_level_classification.py --restore $RUN_DIR/classifier/*run-*/*.ckpt --visualize --device cpu --baseline-level-dir $RUN_DIR/runs --target-level-indices {0..14}
mv wandb/*run-* $RUN_DIR/results/
