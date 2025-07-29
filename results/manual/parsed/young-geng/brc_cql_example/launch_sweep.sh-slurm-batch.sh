#!/bin/bash
#SBATCH --job-name=example_cql
#SBATCH --account=co_rail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:TITAN:1
#SBATCH --mem=24G
#SBATCH --time=3-00:00:00
#SBATCH --qos=rail_gpu3_normal
#SBATCH --array=0-3

export SCRIPT_PATH='$(scontrol show job $SLURM_JOBID | awk -F= '/Command=/{print $2}' | head -n 1)'
export SCRIPT_DIR='$(dirname $SCRIPT_PATH)'
export RUNS_PER_TASK='4'

if [ -z "$SLURM_JOB_ID" ]; then
    echo "This script is not launched with slurm, exiting!"
    exit 1
fi
module load gnu-parallel
export SCRIPT_PATH="$(scontrol show job $SLURM_JOBID | awk -F= '/Command=/{print $2}' | head -n 1)"
export SCRIPT_DIR="$(dirname $SCRIPT_PATH)"
cd $SCRIPT_DIR
OUTPUT_DIR="$SCRIPT_DIR/experiment_output"
EXP_NAME='example_cql_1'
mkdir -p "$OUTPUT_DIR/$EXP_NAME"
cp "$SCRIPT_PATH" "$OUTPUT_DIR/$EXP_NAME/"
export RUNS_PER_TASK=4
parallel --delay 20 --linebuffer -j $RUNS_PER_TASK \
    '[ $SLURM_ARRAY_TASK_ID == $(({#} % $SLURM_ARRAY_TASK_COUNT)) ] && 'singularity run -B /var/lib/dcv-gl --nv --writable-tmpfs $SCRIPT_DIR/code_img.sif \
        SimpleSAC.conservative_sac_main \
            --env={1} \
            --seed={2} \
            --cql.cql_min_q_weight={3} \
            --cql.cql_lagrange=False \
            --cql.cql_temp=1.0 \
            --cql.policy_lr=3e-4 \
            --cql.qf_lr=3e-4 \
            --policy_arch='256-256' \
            --qf_arch='256-256' \
            --eval_period=20 \
            --eval_n_trajs=10 \
            --n_epochs=1000 \
            --device='cuda' \
            --logging.output_dir="$OUTPUT_DIR/example_cql_1" \
            --logging.online=False \
            --logging.prefix='ExampleCQL' \
            --logging.project="$EXP_NAME" \
            --logging.random_delay=60.0 \
        ::: 'hopper-medium-v2' 'walker2d-medium-replay-v2' \
        ::: 42 24 37 \
        ::: 3.0 5.0
