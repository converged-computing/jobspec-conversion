#!/bin/bash
#SBATCH --job-name=TrainTauVertexRHORHO
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5GB
#SBATCH --time=16:00:00
#SBATCH --partition=plgrid
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-0

export PYTHONPATH='$ANACONDA_PYTHON_PATH'

if [ -f setup ]; then source setup; fi
export PYTHONPATH=$ANACONDA_PYTHON_PATH
module add plgrid/apps/cuda/7.5
cd $WORKDIR
echo "TrainCPmix Job. Dropout 0.2. RHORHO"
$ANACONDA_PYTHON_PATH/python2.7 $WORKDIR/main.py -t nn_rhorho_CPmix -i $RHORHO_DATA -e 5 -f Model-OnlyHad -d 0.2 -l 6 -s 300 --unweighted True
