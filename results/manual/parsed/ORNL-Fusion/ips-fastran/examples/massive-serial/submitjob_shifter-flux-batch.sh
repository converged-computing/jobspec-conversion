#!/bin/bash
#FLUX: --job-name=scruptious-punk-3787
#FLUX: -N=2
#FLUX: --priority=16

export BIN_DIR='/global/common/software/atom/cori/binaries'

export BIN_DIR=/global/common/software/atom/cori/binaries
module load python
conda activate massiveparallel
ips.py --config=ips_massive_serial_global_shifter.config --platform=cori_haswell.conf --log=ips.log
