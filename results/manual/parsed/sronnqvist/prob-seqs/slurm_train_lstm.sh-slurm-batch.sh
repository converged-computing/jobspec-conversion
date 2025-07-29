#!/bin/bash
#SBATCH --account=Project_2002026
#SBATCH --output=logs/%j.out
#SBATCH --error=logs/%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=64G
#SBATCH --time=00:15:00
#SBATCH --partition=gputest
#SBATCH --constraint=ntasks-per-node=1

export DATA_DIR='data'
export OUTPUT_DIR='output'

echo "START: $(date)"
rm logs/current.err
rm logs/current.out
ln -s $SLURM_JOBID.err logs/current.err
ln -s $SLURM_JOBID.out logs/current.out
module purge
module load tensorflow
source /scratch/project_2002026/multilabel_bert/neuro_classifier/multilabel/VENV3/bin/activate
export DATA_DIR=data
export OUTPUT_DIR=output
srun python model_prob_seqs.py
echo "END: $(date)"
