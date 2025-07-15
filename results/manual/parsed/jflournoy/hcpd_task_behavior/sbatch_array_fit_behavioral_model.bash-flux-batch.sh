#!/bin/bash
#FLUX: --job-name=conspicuous-car-5675
#FLUX: --urgency=16

chains=(1 2 3 4)
models=(rtagepropot)
Nmodels=${#models[@]}
Nchains=${#chains[@]}
Nrows=$(( $Nmodels * $Nchains - 1))
i=${SLURM_ARRAY_TASK_ID}
if [ -z ${i} ]; then
  echo "Index from 0-${Nrows}"
else
  ichain=$(( $i % $Nchains))
  imodel=$(( $i / $Nchains))
  model=${models[$imodel]}
  chain=${chains[$ichain]}
  echo "Model: $model"
  echo "Chain: $chain"
  cmd="bash /ncf/mclaughlin/users/jflournoy/data/containers/sbatch_R_command_som.bash verse-cmdstan-ggseg-libs.simg fit_behavioral_model.R --model $model --id $chain"
  cmd+=" --refit"
  echo "Command: $cmd"
  exec $cmd
fi
