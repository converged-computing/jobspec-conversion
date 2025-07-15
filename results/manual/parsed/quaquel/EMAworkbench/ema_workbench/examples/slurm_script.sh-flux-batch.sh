#!/bin/bash
#FLUX: --job-name="Python_test"
#FLUX: -n=8
#FLUX: --queue=compute
#FLUX: -t=360
#FLUX: --priority=16

module load 2023r1
module load openmpi
module load python
module load py-numpy
module load py-scipy
module load py-mpi4py
module load py-pip
pip install ipyparallel
pip install --user -e git+https://github.com/quaquel/EMAworkbench@mpi_fixes#egg=ema_workbench
mpiexec -n 1 python3 example_mpi_lake_model.py
