#!/bin/bash
#SBATCH --job-name=m_graph_gen
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2500
#SBATCH --time=4-03:00:00

module purge
module load gcc/8.2.0 python/3.8.5
source $HOME/gcl/bin/activate
cd $HOME/graph-concept-learner-pub/workflows
snakemake pretrain_all
