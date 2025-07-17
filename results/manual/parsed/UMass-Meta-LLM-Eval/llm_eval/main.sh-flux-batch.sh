#!/bin/bash
#FLUX: --job-name=poc-llama7b
#FLUX: -c=8
#FLUX: --queue=gpu-preempt
#FLUX: -t=14400
#FLUX: --urgency=16

module load miniconda/22.11.1-1
module load gcc/11.2.0
module load cuda/12.2.1
conda activate /work/pi_dhruveshpate_umass_edu/grp22/users/<<username>>/conda/envs/<<env-name>>/
cd /work/pi_dhruveshpate_umass_edu/grp22/users/<<username>>/projects/llm_eval/
echo "Running main.py"
python main.py "$@" -j ${SLURM_JOBID}
exit_code=$?
if [ $exit_code -eq 0 ]; then
    echo "Job completed successfully"
else
    echo "Job failed with exit code $exit_code"
fi
