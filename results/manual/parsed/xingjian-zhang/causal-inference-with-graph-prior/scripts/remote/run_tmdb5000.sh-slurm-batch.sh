#!/bin/bash
#SBATCH --job-name=tmdb_causal_graph
#SBATCH --account=qmei3
#SBATCH --output=/home/%u/Research/causal_graph_prior/logs/%x-%j.log
#SBATCH --mail-user=jimmyzxj@umich.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=1gb
#SBATCH --time=00:30:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=4
#SBATCH --array=1-10

PYTHON=/home/jimmyzxj/miniconda3/envs/causal_graph_prior/bin/python3
RANDOM_SEED=${SLURM_ARRAY_TASK_ID}
PROJECT_DIR=/home/jimmyzxj/Research/causal_graph_prior
cd $PROJECT_DIR
make all PYTHON=$PYTHON RANDOM_SEED=$RANDOM_SEED DATASET_CONFIG=tmdb5000_ctrl.yaml
make all PYTHON=$PYTHON RANDOM_SEED=$RANDOM_SEED DATASET_CONFIG=tmdb5000_no_ctrl.yaml
