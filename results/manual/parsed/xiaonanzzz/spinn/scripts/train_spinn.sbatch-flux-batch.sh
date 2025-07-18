#!/bin/bash
#FLUX: --job-name=moolicious-general-8267
#FLUX: --queue=gpu
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:../python'

echo $SLURM_JOBID - `hostname` - $SPINN_FLAGS >> ~/spinn_machine_assignments.txt
module load python/intel/2.7.12 pytorch/intel/20170125 protobuf/intel/3.1.0
pip install --user python-gflags==2.0
export PYTHONPATH=$PYTHONPATH:../python
python -m spinn.models.fat_classifier  --noshow_progress_bar --gpu 0 $SPINN_FLAGS
