#!/bin/bash
#FLUX: --job-name=lovable-poo-0484
#FLUX: -n=48
#FLUX: --queue=micro
#FLUX: -t=1790
#FLUX: --urgency=16

module load spack/22.2.1
module load intel-oneapi-toolkit/2022.3.0
module load hdf5/1.8.22-intel21-impi
module list
echo "PWD: $PWD"
date
srun ./athena -i ../tst/megKH/athinputmeg.kh
date
