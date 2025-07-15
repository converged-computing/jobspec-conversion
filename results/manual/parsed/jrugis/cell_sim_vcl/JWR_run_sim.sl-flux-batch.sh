#!/bin/bash
#FLUX: --job-name=bloated-omelette-3971
#FLUX: -t=900
#FLUX: --urgency=16

echo $HOSTNAME
module load intel/2015a
module load Python/3.5.0-intel-2015a
srun -o sim.log ./src/cell_3d
python scripts/compare_bin.py c.bin c_REF.bin 1e-5
