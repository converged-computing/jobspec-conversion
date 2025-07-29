#!/bin/bash
#SBATCH --job-name=ips_fastran
#SBATCH --account=atom
#SBATCH --output=ips.out
#SBATCH --error=ips.err
#SBATCH --nodes=10
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --time=2-00:00:00
#SBATCH --constraint=haswell,haswell

export EFIT_BIN_DIR='/global/common/software/atom/cori/binaries/efit/default'
export EFIT_BIN_NAME='efitd90'

singularity
exec
docker:registry.services.nersc.gov/rwp53/ips-massive-serial:latest
module load gcc
WORK_DIRECTORY=tokamak_design
rm -rf $SCRATCH/$WORK_DIRECTORY
mkdir $SCRATCH/$WORK_DIRECTORY
cp -rd * $SCRATCH/$WORK_DIRECTORY
cd $SCRATCH/$WORK_DIRECTORY
source activate /global/common/software/atom/cori/adaptive/conda
export EFIT_BIN_DIR=/global/common/software/atom/cori/binaries/efit/default
export EFIT_BIN_NAME=efitd90
ips.py --platform=platform.conf --simulation=ips.ml_train.config
wait
