#!/bin/bash
#SBATCH --job-name={{script_name}}_{{run_id}}
#SBATCH --output=jobs/{{script_name}}_{{run_id}}.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=128G
#SBATCH --time=04:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1,a100

module --force purge
source ~/.bashrc
module load modules/2.2
module load python/3.10.10
module load cuda/11.8 cudnn nccl
module load slurm
pysource stacking
task={{task}}
num_simulations={{num_simulations}}
wb_project=stacking
wb_group=npe_$task
wb_name=npe_$task
wb_sweep_cnt={{wb_sweep_cnt}}
BASE_DIR=~/stacking/
SCRIPTS_DIR="$BASE_DIR/sbi_stacking/scripts/"
OUTPUT_DIR="$BASE_DIR/npes/$wb_name/"
cd "$SCRIPTS_DIR"
echo "--- NPE Job ---"
echo "Task: $task"
echo "Python path: $(which python3)"
echo "Output dir: $OUTPUT_DIR"
python src/npe.py \
        --task $task \
        --num_simulations $num_simulations \
        --wb_project $wb_project \
        --wb_group $wb_group \
        --wb_name $wb_name \
        --wb_sweep_id {{sweep_id}} \
        --wb_sweep_cnt $wb_sweep_cnt \
        --output_dir "$OUTPUT_DIR"
