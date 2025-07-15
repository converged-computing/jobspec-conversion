#!/bin/bash
#FLUX: --job-name=astute-malarkey-9330
#FLUX: --urgency=16

export PYTHONPATH='/pdc/vol/nest/2.2.2/lib/python2.7/site-packages:/pdc/vol/python/2.7.6-gnu/lib/python2.7/site-packages'
export TMP='$(pwd)'

module swap PrgEnv-cray PrgEnv-gnu
module add python
module add nest
echo $LD_LIBRARY_PATH
export PYTHONPATH=/pdc/vol/nest/2.2.2/lib/python2.7/site-packages:/pdc/vol/python/2.7.6-gnu/lib/python2.7/site-packages
export TMP=$(pwd)
rm merge_delme_output
rm merge_error_file.e
temp="merge_delme_output"
echo "Merging, `date`"
aprun -n 10 python /cfs/milner/scratch/b/berthet/code/dopabg/MergeVoltfiles.py > $temp 2>&1
echo "Stopping at `date`"
