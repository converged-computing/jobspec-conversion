#!/bin/bash
#FLUX: --job-name=faux-despacito-7343
#FLUX: --priority=16

cat $0
ml GCCcore/5.4.0
ml GCCcore/6.3.0
ml GCCcore/6.4.0
ml GCCcore/7.3.0
ml GCCcore/8.2.0
ml hwloc/1.11.11
ml GCCcore/8.3.0
ml UCX/1.6.1
ml PMIx/3.0.2
ml GCC/8.2.0-2.31.1  OpenMPI/3.1.3
ml matplotlib/3.0.3-Python-3.7.2
ml PyTorch/1.1.0-Python-3.7.2
pwd
source /afs/hpc2n.umu.se/home/e/erwulff/Public/vpyenv/bin/activate
which python
python --version
echo "Starting grid search..."
python 000_train
echo "Grid search ended."
echo "End of job."
