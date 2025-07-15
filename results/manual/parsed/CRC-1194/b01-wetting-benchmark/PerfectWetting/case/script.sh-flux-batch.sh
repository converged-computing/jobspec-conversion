#!/bin/bash
#FLUX: --job-name=purple-punk-9050
#FLUX: --priority=16

module load git
module load gcc/9.2.0
module load openmpi/4.0.3
module load boost
module load eigen/3.3.7
module load cmake
module load python/3.7.4
module load gnuplot
module load texlive
source /work/projects/special00005/B01/OpenFOAM-v2112/etc/bashrc
srun -n 144 interFlow -parallel -fileHandler collated > log
srun -n 144 foamToVTK -parallel > log.foamToVTK
