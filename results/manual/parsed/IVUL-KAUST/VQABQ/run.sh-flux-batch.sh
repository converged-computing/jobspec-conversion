#!/bin/bash
#FLUX: --job-name=VQA
#FLUX: --queue=workq
#FLUX: -t=32400
#FLUX: --urgency=16

export PATH='/scratch/alfadlmm/miniconda2/bin:$PATH'

module purge		# clean up loaded modules 
module load slurm
export PATH="/scratch/alfadlmm/miniconda2/bin:$PATH"
source activate vqa
for i in {0..14}
do
	srun python solve.py $i &
done
wait
