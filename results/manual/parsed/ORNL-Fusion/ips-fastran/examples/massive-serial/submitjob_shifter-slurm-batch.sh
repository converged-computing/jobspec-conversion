#!/bin/bash
#SBATCH --job-name=ips_fastran
#SBATCH --output=ips.out
#SBATCH --error=ips.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=debug
#SBATCH --constraint=haswell

export BIN_DIR='/global/common/software/atom/cori/binaries'

singularity
exec
docker:registry.services.nersc.gov/rwp53/ips-massive-serial:dev
export BIN_DIR=/global/common/software/atom/cori/binaries
module load python
conda activate massiveparallel
ips.py --config=ips_massive_serial_global_shifter.config --platform=cori_haswell.conf --log=ips.log
