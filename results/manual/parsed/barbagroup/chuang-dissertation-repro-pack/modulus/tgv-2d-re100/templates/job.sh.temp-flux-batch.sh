#!/bin/bash
#FLUX: --job-name=TGV100
#FLUX: --queue={partition}
#FLUX: -t=14400
#FLUX: --urgency=16

export ROOT='$(dirname ${{SCRIPTPATH}})'
export IMAGE='${{HOME}}/images/modulus-22.03.sif'
export TIME='$(date +"%s")'
export LOG='${{ROOT}}/logs/run-${{TIME}}.log'

if [ -n "${{SLURM_JOB_ID}}" ] ; then
    SCRIPTPATH=$(scontrol show job ${{SLURM_JOB_ID}} | grep -Po "(?<=Command=).*$")
else
    SCRIPTPATH=$(realpath $0)
fi
export ROOT=$(dirname ${{SCRIPTPATH}})
export IMAGE=${{HOME}}/images/modulus-22.03.sif
export TIME=$(date +"%s")
mkdir -p ${{ROOT}}/logs
export LOG=${{ROOT}}/logs/run-${{TIME}}.log
echo "Current epoch time: ${{TIME}}" >> ${{LOG}}
echo "Case folder: ${{ROOT}}" >> ${{LOG}}
echo "Job script: ${{SCRIPTPATH}}" >> ${{LOG}}
echo "Singularity image: ${{IMAGE}}" >> ${{LOG}}
echo "Number of GPUs: ${{SLURM_GPUS}}" >> ${{LOG}}
echo "" >> ${{LOG}}
echo "===============================================================" >> ${{LOG}}
lscpu 2>&1 >> ${{LOG}}
echo "===============================================================" >> ${{LOG}}
echo "" >> ${{LOG}}
echo "===============================================================" >> ${{LOG}}
nvidia-smi -L 2>&1 >> ${{LOG}}
echo "===============================================================" >> ${{LOG}}
echo "Start the run" >> ${{LOG}}
srun -n ${{SLURM_GPUS}} \
    singularity run --nv ${{IMAGE}} python ${{ROOT}}/main.py 2>&1 > ${{LOG}}
