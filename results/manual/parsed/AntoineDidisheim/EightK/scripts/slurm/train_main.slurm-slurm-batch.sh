#!/bin/bash
#SBATCH --job-name=train_new_
#SBATCH --account=punim2039
#SBATCH --output=/home/adidishe/EightK/out/train_new_%a.out
#SBATCH --error=/home/adidishe/EightK/out/train_new_%a.err
#SBATCH --mail-user=antoine.didisheim@unimelb.edu.au
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=94G
#SBATCH --time=1-00:00:00
#SBATCH --chdir=/home/adidishe/EightK
#SBATCH --array=0-131

module load foss/2022a
module load GCCcore/11.3.0; module load Python/3.10.4
module load  cuDNN/8.4.1.50-CUDA-11.7.0
module load TensorFlow/2.11.0-CUDA-11.7.0
source  ~/venvs/nlp_gpu/bin/activate
python3 train_new.py ${SLURM_ARRAY_TASK_ID}
