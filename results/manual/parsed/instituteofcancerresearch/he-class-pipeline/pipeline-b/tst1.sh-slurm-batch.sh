#!/bin/bash
#FLUX: --job-name=tensorflow_sim
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load cuda/11.1
log_output="$1"
echo "Log output: $log_output"
data_input="$2"
echo "Data input: $data_input"
sing_im="$3/he-class-alma.sif"
echo "Singularity image: $sing_im"
echo "Pulling the singularity image with the following command: singularity pull $sing_im docker://icrsc/he-class-alma"
singularity pull "$sing_im" docker://icrsc/he-class-alma
echo "Running the singularity container with the following command: singularity run --nv --bind $log_output:/heapplog/ $sing_im python tst1.py /heapplog/ $data_input"
singularity run --nv --bind "$log_output":/heapplog/ "$sing_im" python ./he-class-pipeline/pipeline-b/tst1.py /heapplog/ "$data_input"
