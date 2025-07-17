#!/bin/bash
#FLUX: --job-name=crunchy-lemon-1890
#FLUX: --queue=cox
#FLUX: -t=864720
#FLUX: --urgency=16

export LIBRARY_PATH='/n/home05/haehn/nolearncox/src/hdf5-1.8.17/hdf5/lib:$LIBRARY_PATH'
export LD_LIBRARY_PATH='/n/home05/haehn/nolearncox/src/hdf5-1.8.17/hdf5/lib:$LD_LIBRARY_PATH'
export CPATH='/n/home05/haehn/nolearncox/src/hdf5-1.8.17/hdf5/include:$CPATH'
export FPATH='/n/home05/haehn/nolearncox/src/hdf5-1.8.17/hdf5/include:$FPATH'

source new-modules.sh
module load Anaconda/2.5.0-fasrc01
module load gcc/4.9.0-fasrc01
module load cuda/7.5-fasrc01
module load cudnn/7.0-fasrc01
module load opencv/3.0.0-fasrc04
export LIBRARY_PATH=/n/home05/haehn/nolearncox/src/hdf5-1.8.17/hdf5/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=/n/home05/haehn/nolearncox/src/hdf5-1.8.17/hdf5/lib:$LD_LIBRARY_PATH
export CPATH=/n/home05/haehn/nolearncox/src/hdf5-1.8.17/hdf5/include:$CPATH
export FPATH=/n/home05/haehn/nolearncox/src/hdf5-1.8.17/hdf5/include:$FPATH
source /n/home05/haehn/nolearncox/bin/activate
cd /n/home05/haehn/Projects/gp/train/
python ip.py
exit 0;
