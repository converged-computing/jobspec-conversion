#!/bin/bash
#SBATCH --account=somerville_lab
#SBATCH --output=/n/home_fasse/jflournoy/data/containers/log/%A_%a-%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=48G
#SBATCH --time=7-00:00:00

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
