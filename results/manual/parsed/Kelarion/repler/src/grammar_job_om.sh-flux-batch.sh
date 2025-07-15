#!/bin/bash
#FLUX: --job-name=persnickety-rabbit-4994
#FLUX: --priority=16

module load openmind/singularity/3.2.0        # load singularity module
singularity exec -B /om2,/om3  /om2/user/malleman/everything.simg python grammar_script.py $SLURM_ARRAY_TASK_ID   # Run the job steps
