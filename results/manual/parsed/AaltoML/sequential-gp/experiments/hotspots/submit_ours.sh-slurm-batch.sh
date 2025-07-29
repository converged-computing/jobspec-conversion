#!/bin/bash
#SBATCH --output=./hotspots_ours_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=20000M
#SBATCH --time=03:00:00
#SBATCH --constraint=volta
#SBATCH --array=1-50

module load miniconda
source activate ovcexperiment
mkdir -p output_dir
python hotspots.py --seed=$SLURM_ARRAY_TASK_ID --n_batch=100 --batch_limit=8 --num_init=100 \
    --beta=1.0 --loss=elbo --dataset=civ --inner_samples=16 --outer_samples=16 \
    --use_tsvgp --output=output_dir/civ_ind_svgp_${SLURM_ARRAY_TASK_ID}_AMD_tsvgp.pt
