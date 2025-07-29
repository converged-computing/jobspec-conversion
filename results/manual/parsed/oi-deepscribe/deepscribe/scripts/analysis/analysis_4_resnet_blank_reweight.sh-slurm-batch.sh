#!/bin/bash
#SBATCH --output=slogs/confusion-4-resnet-%j.out
#SBATCH --error=slogs/confusion-4-resnet-%j.err
#SBATCH --mail-user=eddiecwilliams@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16G
#SBATCH --partition=gpu2

module load cuda/9.1
SIGNS='["na","HAL","iš","MEŠ"]'
luigi --module deepscribe.pipeline.analysis RunAnalysisOnTestDataTask --local-scheduler \
      --imgfolder data/ochre/a_pfa \
      --hdffolder ../deepscribe-data/processed/pfa_new \
      --modelsfolder models \
      --target-size 50 \
      --keep-categories $SIGNS  \
      --fractions '[0.7, 0.1, 0.2]' \
      --model-definition data/model_defs/resnet50_blank_reweight.json
