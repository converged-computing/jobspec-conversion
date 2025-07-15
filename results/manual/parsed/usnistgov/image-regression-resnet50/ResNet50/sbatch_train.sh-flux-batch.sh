#!/bin/bash
#FLUX: --job-name=resnet50
#FLUX: -c=160
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

test_every_n_steps=1000
batch_size=8 # 4x across the gpus
train_lmdb_file="train.lmdb"
test_lmdb_file="test.lmdb"
input_data_folder="/path/to/input/directory/where/lmdb/are/saved"
output_folder="/path/to/output/directory/where/results/are/saved"
experiment_name="resnet50-$(date +%Y%m%dT%H%M%S)"
learning_rate=1e-4
use_augmentation=1
echo "Experiment: $experiment_name"
scratch_dir="/scratch/${SLURM_JOB_ID}"
term_handler()
{
        echo "function term_handler called.  Cleaning up and Exiting"
        # cleanup scratch dir
        rm -rf ${scratch_dir}/*
        exit -1
}
trap 'term_handler' TERM
source /opt/anaconda3/etc/profile.d/conda.sh
conda activate tf2
mkdir -p ${scratch_dir}
echo "Created Directory: $scratch_dir"
echo "Copying data to Node"
cp -r ${input_data_directory}/${train_lmdb_file} ${scratch_dir}/${train_lmdb_file}
cp -r ${input_data_directory}/${test_lmdb_file} ${scratch_dir}/${test_lmdb_file}
echo "data copy to node complete"
echo "Working directory contains: "
ls ${scratch_dir}
results_dir="$output_directory/$experiment_name"
mkdir -p ${results_dir}
echo "Results Directory: $results_dir"
mkdir -p "$results_dir/src"
cp -r . "$results_dir/src"
echo "Launching Training Script"
python train.py --test_every_n_steps=${test_every_n_steps} --batch_size=${batch_size} --train_database="$scratch_dir/$train_lmdb_file" --test_database="$scratch_dir/$test_lmdb_file" --output_dir="$results_dir" --learning_rate=${learning_rate}  --use_augmentation=${use_augmentation} | tee "$results_dir/log.txt"
rm -rf ${scratch_dir}/*
echo "Job completed"
