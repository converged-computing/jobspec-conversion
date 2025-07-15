#!/bin/bash
#FLUX: --job-name=OptionPricing
#FLUX: -t=1800
#FLUX: --urgency=16

module load anaconda3
conda activate tf-gpu
srun python main.py --problem_name=PricingOptionOneFactor
