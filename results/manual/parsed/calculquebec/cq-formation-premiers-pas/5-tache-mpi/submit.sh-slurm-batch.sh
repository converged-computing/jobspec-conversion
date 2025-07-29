#!/bin/bash
#SBATCH --job-name=ex5
#SBATCH --account=def-sponsor00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=1000M
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=1

SRCDIR=/project/def-sponsor00/photos/
FILTERS="grayscale edges emboss negate solarize flip flop monochrome add_noise"
../filterImage.exe --srcdir $SRCDIR --files $(ls $SRCDIR) --filters $FILTERS
