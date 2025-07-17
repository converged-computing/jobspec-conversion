#!/bin/bash
#FLUX: --job-name=dqn
#FLUX: -c=8
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: --urgency=16

cd /scratch/lu.xue/dec-hdrqn
srun python main.py --gridx 3 --gridy 3 --n_quant 16  --implicit 1 --likely 1 --distort_type wang --distort_param 0.0  --run_id $SLURM_ARRAY_TASK_ID
