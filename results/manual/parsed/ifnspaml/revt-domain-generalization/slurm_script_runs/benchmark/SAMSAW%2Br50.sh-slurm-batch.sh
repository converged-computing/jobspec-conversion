#!/bin/bash
#SBATCH --job-name=SAMSAW+r50.sh_Benchmark
#SBATCH --output=SAMSAW+r50.sh_Benchmark-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu
#SBATCH --mem=32000M
#SBATCH --time=7-00:00:00
#SBATCH --partition=gpu,gpub
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --exclude=gpu[01-05,07]

cd ~/work/transformer-domain-generalization || return
module load comp/gcc/11.2.0
source activate transformer-domain-generalization
nvidia-smi
echo -e "Node: $(hostname)"
echo -e "Job internal GPU id(s): $CUDA_VISIBLE_DEVICES"
echo -e "Job external GPU id(s): ${SLURM_JOB_GPUS}"
srun python ./tools/benchmark.py local_configs/ResNet/50/SAMSAWR50.b5.512x512.gta2cs.40k.batch2.py
