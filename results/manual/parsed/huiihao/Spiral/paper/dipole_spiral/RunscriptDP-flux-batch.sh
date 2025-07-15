#!/bin/bash
#FLUX: --job-name=cowy-house-5688
#FLUX: --queue=v100
#FLUX: --urgency=16

/storage/liushiLab/huyihao/DPMD/Version2.0.1/bin/lmp -in input_npt.lammps > lmp.log
