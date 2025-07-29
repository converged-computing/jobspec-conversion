#!/bin/bash
#FLUX: --job-name=APE_test_1
#FLUX: -N=2
#FLUX: -c=4
#FLUX: --queue=gp1d
#FLUX: --urgency=16

module load miniconda3
conda info --envs
huggingface-cli whoami
conda activate /home/kodmas2023/miniconda3/envs/ape
python ../experiments/run_instruction_induction.py --task=informal_to_formal
