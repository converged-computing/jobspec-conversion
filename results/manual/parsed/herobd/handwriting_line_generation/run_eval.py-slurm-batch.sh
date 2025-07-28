#!/bin/bash
#FLUX: --job-name=eval
#FLUX: -n=5
#FLUX: -t=1800
#FLUX: --urgency=16

export PBS_NODEFILE='`/fslapps/fslutils/generate_pbs_nodefile`'
export PBS_JOBID='$SLURM_JOB_ID'
export PBS_O_WORKDIR='$SLURM_SUBMIT_DIR'
export PBS_QUEUE='batch'
export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export PBS_NODEFILE=`/fslapps/fslutils/generate_pbs_nodefile`
export PBS_JOBID=$SLURM_JOB_ID
export PBS_O_WORKDIR="$SLURM_SUBMIT_DIR"
export PBS_QUEUE=batch
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
module load cuda/10.1
module load cudnn/7.6
cd ~/hw_with_style
source deactivate
source activate c10
python new_eval.py -c saved/fontNAF32_ocr_softmax_1huge/checkpoint-iteration500000.pth -g 0 -f cf_test_on_FUNSD.json
