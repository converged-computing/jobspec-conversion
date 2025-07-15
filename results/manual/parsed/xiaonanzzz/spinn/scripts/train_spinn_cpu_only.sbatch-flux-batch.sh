#!/bin/bash
#FLUX: --job-name=faux-itch-8242
#FLUX: --priority=16

echo $SLURM_JOBID - `hostname` - $SPINN_FLAGS >> ~/spinn_machine_assignments.txt
module load python/intel/2.7.12 pytorch/intel/20170125 protobuf/intel/3.1.0
python -m spinn.models.fat_classifier  --noshow_progress_bar $SPINN_FLAGS
