#!/bin/bash
#SBATCH --job-name=ips_fastran
#SBATCH --account=atom
#SBATCH --output=ips.out
#SBATCH --error=ips.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=debug
#SBATCH --constraint=haswell,haswell

singularity
exec
docker:registry.services.nersc.gov/rwp53/ips-massive-serial:dev
module load gcc
module load python
WORK_DIRECTORY=tokamak_design_nb_debug_shifter
rm -rf $SCRATCH/$WORK_DIRECTORY
mkdir $SCRATCH/$WORK_DIRECTORY
cp -rd * $SCRATCH/$WORK_DIRECTORY
cd $SCRATCH/$WORK_DIRECTORY
source activate /global/common/software/atom/cori/adaptive/conda
ips.py --platform=platform.conf --simulation=ips.ml_train.config
wait
