#!/bin/bash
#FLUX: --job-name=goodbye-lentil-5547
#FLUX: --priority=16

export PROJ_LIB='/global/homes/t/tkurth/.conda/envs/mlperf_deepcam/share/basemap'
export PYTHONPATH='/global/homes/t/tkurth/.conda/envs/mlperf_deepcam/lib/python3.7/site-packages:${PYTHONPATH}'

conda activate mlperf_deepcam
module load pytorch/v1.4.0
export PROJ_LIB=/global/homes/t/tkurth/.conda/envs/mlperf_deepcam/share/basemap
export PYTHONPATH=/global/homes/t/tkurth/.conda/envs/mlperf_deepcam/lib/python3.7/site-packages:${PYTHONPATH}
rankspernode=1
totalranks=$(( ${SLURM_NNODES} * ${rankspernode} ))
run_tag="deepcam_prediction_run1-cori"
data_dir_prefix="/global/cscratch1/sd/tkurth/data/cam5_data/All-Hist"
output_dir="/global/cscratch1/sd/tkurth/data/cam5_runs/${run_tag}"
mkdir -p ${output_dir}
touch ${output_dir}/train.out
srun -u -N ${SLURM_NNODES} -n ${totalranks} -c $(( 256 / ${rankspernode} )) --cpu_bind=cores \
     python ../train_hdf5_ddp.py \
     --wireup_method "mpi" \
     --run_tag ${run_tag} \
     --data_dir_prefix ${data_dir_prefix} \
     --output_dir ${output_dir} \
     --max_inter_threads 0 \
     --model_prefix "classifier" \
     --optimizer "AdamW" \
     --start_lr 1e-3 \
     --lr_schedule type="multistep",milestones="15000 25000",decay_rate="0.1" \
     --lr_warmup_steps 0 \
     --lr_warmup_factor $(( ${SLURM_NNODES} / 8 )) \
     --weight_decay 1e-2 \
     --validation_frequency 200 \
     --training_visualization_frequency 200 \
     --validation_visualization_frequency 40 \
     --max_validation_steps 50 \
     --logging_frequency 0 \
     --save_frequency 400 \
     --max_epochs 200 \
     --amp_opt_level O1 \
     --local_batch_size 2 |& tee -a ${output_dir}/train.out
