#!/bin/bash
#FLUX: --job-name=milky-truffle-1994
#FLUX: --exclusive
#FLUX: -t=54000
#FLUX: --urgency=16

export PYTHONPATH='`spack find --paths /$SPACK_INSTALLED_HASH | tail -n 1 | grep -o "/.*"`:$PYTHONPATH'

set -x
module load unstable python-dev python
export PYTHONPATH=`spack find --paths /$SPACK_INSTALLED_HASH | tail -n 1 | grep -o "/.*"`:$PYTHONPATH
nodes=$SLURM_JOB_NUM_NODES
ntasks=$(($nodes * 32))
if [[ -z "${steps_version}" ]]
then
  steps_version=4
fi
for b in {0..9}
do
    seed=$(($SLURM_ARRAY_TASK_ID*10+b+1))
    time srun --nodes=$nodes --ntasks=$ntasks dplace \
    python rallpack3.py $seed mesh/axon_cube_L1000um_D866nm_1135tets.msh $steps_version
done
