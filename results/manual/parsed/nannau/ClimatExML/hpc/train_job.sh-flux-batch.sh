#!/bin/bash
#FLUX: --job-name=chunky-underoos-3980
#FLUX: -c=6
#FLUX: -t=432960
#FLUX: --urgency=16

export PROJECT_DIR='$SLURM_TMPDIR # code uses project dir as base.'
export DATA_DIR='$SLURM_TMPDIR/data'
export OUTPUT_COMET_ZIP='$HOME/scratch'
export CODE_PATH='/home/nannau/scratch/comet/'
export HOST_DATA_PATH='/home/nannau/scratch/data'
export NCCL_BLOCKING_WAIT='1'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

echo "CONFIG OPTIONS"
export PROJECT_DIR=$SLURM_TMPDIR # code uses project dir as base.
export DATA_DIR=$SLURM_TMPDIR/data
export OUTPUT_COMET_ZIP=$HOME/scratch
export CODE_PATH=/home/nannau/scratch/comet/
export HOST_DATA_PATH=/home/nannau/scratch/data
echo "END CONFIG OPTIONS"
echo "INSTALL SOFTWARE"
rsync -av --progress $CODE_PATH $SLURM_TMPDIR/
module load python
unset KUBERNETES_PORT # mysterious, needs to be here. Not sure why.
virtualenv --no-download ${PROJECT_DIR}/mlenv
source ${PROJECT_DIR}/mlenv/bin/activate
pip install --no-index --upgrade pip
pip install --no-index ${PROJECT_DIR}/ClimatExML/
echo "END INSTALL"
echo "SET RANDOM NODE VARS"
export NCCL_BLOCKING_WAIT=1
unset OMP_NUM_THREADS # mysterious, needs to be here. Not sure why.
unset COMET_API_KEY # force offline mode
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
echo "END SET"
echo "COPY AND EXTRACT DATA"
rsync -av --progress $HOST_DATA_PATH $SLURM_TMPDIR/
for var in uas vas tas RH pr; do
    echo
    echo "Extracting validation $var"
    echo
    tar -xf $SLURM_TMPDIR/data/validation/$var.tar.gz -C $SLURM_TMPDIR/data --checkpoint=.50000
done
for var in uas vas tas RH pr; do
    echo
    echo "Extracting train $var"
    echo
    tar -xf $SLURM_TMPDIR/data/train/$var.tar.gz -C $SLURM_TMPDIR/data --checkpoint=.50000
done
echo "END COPY"
echo "RUN TRAINING"
unset OMP_NUM_THREADS
python ${PROJECT_DIR}/ClimatExML/ClimatExML/train.py 
