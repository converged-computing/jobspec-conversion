#!/bin/bash
#SBATCH --job-name=BestInf
#SBATCH --output=../logs/sanitycheck_%A_%a.out
#SBATCH --error=../logs/sanitycheck_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=96GB
#SBATCH --time=01:00:00
#SBATCH --array=0

echo `hostname`
DIR=../src
cd $DIR
echo `pwd`
VIDEO_FEATURES_FILENAME=../data/ResNexT-101_3D_video_features.h5 
AUDIO_FEATURES_FILENAME=../data/ResNet-18_audio_features.h5
TRAIN_LABELS_FILENAME=../data/subset_moviescenes_shotcuts_train.csv
VAL_LABELS_FILENAME=../data/subset_moviescenes_shotcuts_val.csv
DURATIONS_FILENAME=../data/durations.csv
DEVICE=cuda:0
BATSH_SIZE=256
LOG_DIR=../checkpoints/best_state.ckpt
TOP_K=30
CSV_PATH="../results/video_audio_inference.csv"
python inference.py --train_labels_filename $TRAIN_LABELS_FILENAME \
                --val_labels_filename $VAL_LABELS_FILENAME \
                --durations_filename $DURATIONS_FILENAME \
                --log_dir $LOG_DIR \
                --device $DEVICE \
                --batch_size $BATSH_SIZE \
                --features_file_names $VIDEO_FEATURES_FILENAME \
                --features_file_names $AUDIO_FEATURES_FILENAME \
                --top_k $TOP_K \
                --th_distances 1 2 3 \
                --split val \
                --csv_path $CSV_PATH \
