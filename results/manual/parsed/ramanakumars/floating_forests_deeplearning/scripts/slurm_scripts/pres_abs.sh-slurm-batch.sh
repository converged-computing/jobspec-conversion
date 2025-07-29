#!/bin/bash
#SBATCH --job-name=pres_abs_resnet50_ff_image_mod
#SBATCH --output=pres_abs_resnet50_ff_image_mod.out
#SBATCH --error=pres_abs_resnet50_ff_image_mod.err
#SBATCH --mail-user=jarrett.byrnes@umb.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem-per-cpu=64G
#SBATCH --time=14-10:00:00

module load proj-7.1.0-gcc-8.4.0-sjt4ita
module load R/4.0.3
module load python/3.5.1
module load cuda/10.1-update2
module load gdal-3.2.0-gcc-8.4.0-fpys6w7
module load geos-3.8.1-gcc-8.4.0-awcmh22
cd /home/jarrett.byrnes/floating-forests/floating_forests_deeplearning/scripts/presence_abscence_model
Rscript ff_resnet_tiff_generator.R
