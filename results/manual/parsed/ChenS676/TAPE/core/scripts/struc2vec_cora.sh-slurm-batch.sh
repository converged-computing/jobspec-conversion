#!/bin/bash
#SBATCH --job-name=tag_struc2vec
#SBATCH --output=log/TAG_Benchmar_%j.output
#SBATCH --error=error/TAG_Benchmark_%j.error
#SBATCH --mail-user=cc7738@kit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1600mb
#SBATCH --time=4-00:00:00
#SBATCH --chdir=/hkfs/work/workspace/scratch/cc7738-benchmark_tag/TAPE/scripts

source /hkfs/home/project/hk-project-test-p0021478/cc7738/anaconda3/etc/profile.d/conda.sh
conda activate base
conda activate TAG-LP
cd /hkfs/work/workspace/scratch/cc7738-benchmark_tag/TAPE/core/Embedding
module purge
module load devel/cmake/3.18
module load devel/cuda/11.8
module load compiler/gnu/12
ls -ltr
python wb_tune_struc2vec.py --sweep core/yamls/cora/struc2vec_sp3.yaml --cfg core/yamls/cora/struc2vec.yaml 
