#!/bin/bash
#SBATCH --job-name=audio-clean
#SBATCH --account=cascades
#SBATCH --output=temp/audio-clean.out
#SBATCH --error=temp/audio-clean.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=3-00:00:00
#SBATCH --nodelist=cn-m-2

module load cuda/11.7 sox
cd /nfs/guille/eecs_research/soundbendor/zontosj/instrument_classification_with_pytorch/data/rwc_all
/nfs/guille/eecs_research/soundbendor/zontosj/opt/bin/audio-clean.sh
cd clean
/nfs/guille/eecs_research/soundbendor/zontosj/opt/bin/audio-split.sh
