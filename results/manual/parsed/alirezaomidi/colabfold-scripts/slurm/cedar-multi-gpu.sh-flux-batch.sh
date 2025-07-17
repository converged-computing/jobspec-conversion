#!/bin/bash
#FLUX: --job-name=colabfold
#FLUX: -c=24
#FLUX: -t=259080
#FLUX: --urgency=16

sbatch <<EOT
module load gcc/9.3.0 openmpi/4.0.3 cuda/11.4 cudnn/8.2.0 kalign/2.03 hmmer/3.2.1 openmm-alphafold/7.5.1 hh-suite/3.3.0 python/3.8 mmseqs2
source ~/alphafold_env/bin/activate
nvidia-smi
mkdir -p $2/
BEGIN=\$((\$SLURM_ARRAY_TASK_ID * 4))
END=\$((\$BEGIN + 3))
echo "$@"
srun parallel -j4 CUDA_VISIBLE_DEVICES='{=1 \$_=\$arg[1]%4 =}' python -u batch.py \
     --num-recycle 20 \
     --recycle-early-stop-tolerance 0.5 \
     --model-type alphafold2_multimer_v2 \
     --num-seeds 1 \
     --zip \
     --n-batch 8 \
     --batch-id {} \
     $@ ::: \$(seq \$BEGIN \$END)
EOT
