#!/bin/bash
#SBATCH --job-name=CodeCG
#SBATCH --output=/scratch/bhanu/CodeCG/outs/nl2nl-%j.out
#SBATCH --error=/scratch/bhanu/CodeCG/outs/nl2nl-%j.err
#SBATCH --mail-user=f20190083@hyderabad.bits-pilani.ac.in
#SBATCH --mail-type=NONE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=1

spack unload 
spack load gcc@11.2.0
spack load cuda@11.7.1%gcc@11.2.0 arch=linux-rocky8-zen2
spack load python@3.9.13%gcc@11.2.0 arch=linux-rocky8-zen2
source ~/CodeCG/codecg/bin/activate
cd ~/CodeCG/code
srun ~/CodeCG/codecg/bin/python main.py \
--run_name nl2nl-run-3 \
--jobid $SLURM_JOB_ID \
--logger wandb \
--path_logs "/scratch/bhanu/CodeCG/logs" \
--path_base_models "/scratch/bhanu/CodeCG/base_models" \
--path_cache_datasets "/scratch/bhanu/CodeCG/dataset" \
--workers 4 \
--path_save_nl_encoder "/scratch/bhanu/CodeCG/saved_models/nl-encoder" \
--path_save_nl_decoder "/scratch/bhanu/CodeCG/saved_models/nl-decoder" \
--path_save_nl_lm "/scratch/bhanu/CodeCG/saved_models/nl-lm" \
--epochs 5 \
