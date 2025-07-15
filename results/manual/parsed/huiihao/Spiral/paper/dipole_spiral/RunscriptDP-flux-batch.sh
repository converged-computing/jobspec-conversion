#!/bin/bash
#FLUX: --job-name=delicious-chip-2419
#FLUX: --queue=v100
#FLUX: --priority=16

/storage/liushiLab/huyihao/DPMD/Version2.0.1/bin/lmp -in input_npt.lammps > lmp.log
