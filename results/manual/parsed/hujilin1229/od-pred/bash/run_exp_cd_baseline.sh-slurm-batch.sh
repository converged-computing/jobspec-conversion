#!/bin/bash
#SBATCH --account=aauhpc_slim
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:2
#SBATCH --time=1-00:00:00

echo Running on "$(hostname)"
echo Available nodes: "$SLURM_NODELIST"
echo Slurm_submit_dir: "$SLURM_SUBMIT_DIR"
echo Start time: "$(date)"
python baseline_train_cd.py --test_every_n_epochs 10 --sample_rate 15 --data_format 'speed' --seq_len 3 --horizon 3 --num_gpus 2 --fill_mean=False --sparse_removal=False --base_line 'gp' &
wait
