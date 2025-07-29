#!/bin/bash
#SBATCH --job-name=single
#SBATCH --account=punim2039
#SBATCH --output=/home/adidishe/EightK/out/single.out
#SBATCH --error=/home/adidishe/EightK/out/single.err
#SBATCH --mail-user=antoine.didisheim@unimelb.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=80G
#SBATCH --time=10:00:00
#SBATCH --partition=cascade
#SBATCH --chdir=/home/adidishe/EightK

module load foss/2022a
module load GCCcore/11.3.0; module load Python/3.10.4
module load  cuDNN/8.4.1.50-CUDA-11.7.0
module load TensorFlow/2.11.0-CUDA-11.7.0-deeplearn
source  ~/venvs/nlp_gpu/bin/activate
python3 wip.py
