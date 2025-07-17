#!/bin/bash
#FLUX: --job-name=pres_abs_resnet50_ff_image_mod
#FLUX: -n=10
#FLUX: -t=1245600
#FLUX: --urgency=16

module load proj-7.1.0-gcc-8.4.0-sjt4ita
module load R/4.0.3
module load python/3.5.1
module load cuda/10.1-update2
module load gdal-3.2.0-gcc-8.4.0-fpys6w7
module load geos-3.8.1-gcc-8.4.0-awcmh22
cd /home/jarrett.byrnes/floating-forests/floating_forests_deeplearning/scripts/presence_abscence_model
Rscript ff_resnet_tiff_generator.R
