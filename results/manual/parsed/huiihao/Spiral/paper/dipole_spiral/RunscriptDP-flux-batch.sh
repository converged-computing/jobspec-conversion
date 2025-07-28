#!/bin/bash
#FLUX: --job-name=purple-peas-4744
#FLUX: --queue=v100
#FLUX: -t=720000
#FLUX: --urgency=16

/storage/liushiLab/huyihao/DPMD/Version2.0.1/bin/lmp -in input_npt.lammps > lmp.log
