#!/bin/bash
#SBATCH --job-name=list_topic
#SBATCH --account=punim2039
#SBATCH --output=/home/adidishe/EightK/out/list_topic_%a.out
#SBATCH --error=/home/adidishe/EightK/out/list_topic_%a.err
#SBATCH --mail-user=antoine.didisheim@unimelb.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=20G
#SBATCH --time=10:00:00
#SBATCH --partition=cascade
#SBATCH --chdir=/home/adidishe/EightK
#SBATCH --array=0-323

module load foss/2022a
module load GCCcore/11.3.0; module load Python/3.10.4
module load  cuDNN/8.4.1.50-CUDA-11.7.0
module load TensorFlow/2.11.0-CUDA-11.7.0
source  ~/venvs/nlp_gpu/bin/activate
python3 news_create_list_of_topics.py ${SLURM_ARRAY_TASK_ID}
