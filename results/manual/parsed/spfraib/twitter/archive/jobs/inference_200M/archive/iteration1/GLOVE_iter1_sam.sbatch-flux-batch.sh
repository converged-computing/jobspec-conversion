#!/bin/bash
#FLUX: --job-name=samglove
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
singularity exec --nv /beegfs/work/public/singularity/cuda10.1-cudnn7-devel-ubuntu18.04.sif bash -c "                                                                                                              
source /scratch/spf248/pyenv_dval_wb_twitter_as_sam/py3.7/bin/activate                                                                                                                                             
cd /scratch/da2734/twitter/code/2-twitter_labor/4-inference_200M/
time python -u 10.7-GLOVE_CNN-deploying-100M_random_sam.py > /scratch/da2734/twitter/jobs/running_on_200Msamples/iteration1/logs/glove_sam/${SLURM_ARRAY_TASK_ID}-$(date +%s).log 2>&1                          
exit                                                                                                                                                                                                               
"
