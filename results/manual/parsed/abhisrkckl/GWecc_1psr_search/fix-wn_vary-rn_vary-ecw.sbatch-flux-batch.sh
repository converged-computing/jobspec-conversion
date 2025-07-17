#!/bin/bash
#FLUX: --job-name=gwecc-search
#FLUX: -n=4
#FLUX: --urgency=16

/home/susobhan/Data/susobhan/miniconda/envs/gwecc/bin/activate
PYTHON=$CONDA_PREFIX/bin/python
JULIA=$PYTHON_JULIACALL_BINDIR/julia
source print_info.sh
mpichversion | head -n 1
$PYTHON -c 'from mpi4py import MPI, __version__ as mpi_ver; print("mpi4py version", mpi_ver)'
echo
mpirun -np 4 $PYTHON run_1psr_analysis.py fix-wn_vary-rn_vary-ecw.json
