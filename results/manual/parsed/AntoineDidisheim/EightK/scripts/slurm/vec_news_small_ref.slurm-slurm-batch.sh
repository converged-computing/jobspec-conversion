#!/bin/bash
#SBATCH --job-name=vec_news_ref_
#SBATCH --account=punim2039
#SBATCH --output=/home/adidishe/EightK/out/vec_news_ref_%a.out
#SBATCH --error=/home/adidishe/EightK/out/vec_news_ref_%a.err
#SBATCH --mail-user=antoine.didisheim@unimelb.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=24G
#SBATCH --time=1-00:00:00
#SBATCH --partition=cascade
#SBATCH --chdir=/home/adidishe/EightK
#SBATCH --array=0-26

module load foss/2022a
module load GCCcore/11.3.0; module load Python/3.10.4
module load  cuDNN/8.4.1.50-CUDA-11.7.0
module load TensorFlow/2.11.0-CUDA-11.7.0-deeplearn
module load OpenMPI/4.1.4; module load PyTorch/1.12.1-CUDA-11.7.0
source  ~/venvs/nlp_gpu/bin/activate
python3 vec_main.py ${SLURM_ARRAY_TASK_ID} --legal=0 --eight=0 --news=1 --ref=1 --bow=0 --small=1
