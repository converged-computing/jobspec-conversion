#!/bin/bash
#FLUX: --job-name=polarnet_val
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

export XDG_RUNTIME_DIR='$SCRATCH/tmp/runtime-$SLURM_JOBID'
export PYTHONPATH='$PYTHONPATH:$code_dir'
export LD_LIBRARY_PATH='$WORK/miniconda3/envs/bin/lib:$LD_LIBRARY_PATH'

set -x
set -e
cd ${SLURM_SUBMIT_DIR}
export XDG_RUNTIME_DIR=$SCRATCH/tmp/runtime-$SLURM_JOBID
mkdir $XDG_RUNTIME_DIR
chmod 700 $XDG_RUNTIME_DIR
export PYTHONPATH=/opt/YARR/
module purge
pwd; hostname; date
task_offset=${task_offset:-1}
seed_default=${seed_default:-0}
task=${task:-reach_and_drag}
code_dir=$WORK/Code/polarnet/
task_file=${task_file:-$code_dir/polarnet/assets/peract_tasks_var.csv}
if [ ! -z $SLURM_ARRAY_TASK_ID ]; then
  num_tasks=$(wc -l < $task_file)
  task_id=$(( (${SLURM_ARRAY_TASK_ID} % $num_tasks) + $task_offset ))
  taskvar=$(sed -n "${task_id},${task_id}p" $task_file)
  task=$(echo $taskvar | awk -F ',' '{ print $1 }')
  seed_default=$(( ${SLURM_ARRAY_TASK_ID} / $num_tasks ))
  seed=${seed:-$seed_default}
else
  seed=${seed:-$seed_default}
fi
log_dir=$WORK/logs/
mkdir -p $log_dir
module load singularity
. $WORK/miniconda3/etc/profile.d/conda.sh
export LD_LIBRARY_PATH=$WORK/miniconda3/envs/bin/lib:$LD_LIBRARY_PATH
conda activate polarnet
export PYTHONPATH="$PYTHONPATH:$code_dir"
models_dir=exprs/peract-multi-model/
instr_embed_file=data/taskvar_instrs/clip/
microstep_data_dir=data/peract_data/val/microsteps/
init_step=${init_step:-50000}
max_step=${max_step:-600000}
step_jump=10000
pushd $code_dir/polarnet
for step in $( eval echo {${init_step}..${max_step}..${step_jump}} )
do
srun --export=ALL,XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
    singularity exec \
    --bind $WORK:$WORK,$SCRATCH:$SCRATCH,$STORE:$STORE --nv \
    $SINGULARITY_ALLOWED_DIR/polarnet.sif \
    xvfb-run -a python eval_tst_split.py \
    --exp_config  ${models_dir}/logs/training_config.yaml \
    --seed 100 --num_demos 20 \
    --checkpoint ${models_dir}/ckpts/model_step_${step}.pt \
    --taskvars $taskvar \
    --microstep_data_dir  --microstep_outname microsteps_val_bis --num_workers 1 --instr_embed_file $instr_embed_file
done
popd 
