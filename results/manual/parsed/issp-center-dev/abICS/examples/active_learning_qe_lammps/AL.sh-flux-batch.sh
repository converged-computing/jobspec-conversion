#!/bin/bash
#FLUX: --job-name=carnivorous-spoon-7153
#FLUX: -t=1800
#FLUX: --urgency=16

echo start AL sample
srun -n 8 abics_mlref input.toml >> abics_mlref.out
echo start parallel_run 1
sh parallel_run.sh
echo start AL final
srun -n 8 abics_mlref input.toml >> abics_mlref.out
echo start training
abics_train input.toml >> abics_train.out
echo Done
