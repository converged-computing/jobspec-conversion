#!/bin/bash
#FLUX: --job-name=eccentric-cupcake-9422
#FLUX: -t=1800
#FLUX: --urgency=16

export MASTER_ADDR='$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)'
export MASTER_PORT='12345'
export lc='100'
export epochs='3'
export backbone='resnet18'
export enc_layers='2'
export dec_layers='2'
export dim_ff='512'
export nheads='4'
export num_queries='20'
export file='hgp'
export batch_size='2'

module load gpu
module load conda
conda activate detr_12.2
export MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
export MASTER_PORT=12345
dcgmi profile --pause
metrics="sm__cycles_elapsed.avg,\
sm__cycles_elapsed.avg.per_second,"
metrics+="sm__sass_thread_inst_executed_op_dadd_pred_on.sum,\
sm__sass_thread_inst_executed_op_dfma_pred_on.sum,\
sm__sass_thread_inst_executed_op_dmul_pred_on.sum,"
metrics+="sm__sass_thread_inst_executed_op_fadd_pred_on.sum,\
sm__sass_thread_inst_executed_op_ffma_pred_on.sum,\
sm__sass_thread_inst_executed_op_fmul_pred_on.sum,"
metrics+="sm__sass_thread_inst_executed_op_hadd_pred_on.sum,\
sm__sass_thread_inst_executed_op_hfma_pred_on.sum,\
sm__sass_thread_inst_executed_op_hmul_pred_on.sum,"
metrics+="sm__inst_executed_pipe_tensor.sum,"
metrics+="dram__bytes.sum,\
lts__t_bytes.sum,\
l1tex__t_bytes.sum"
export lc=100
export epochs=3
export backbone="resnet18"
export enc_layers=2
export dec_layers=2
export dim_ff=512
export nheads=4
export num_queries=20
export file="hgp"
export batch_size=2
python="python /global/homes/m/marcolz/DETR/hgp_detr/main.py"
args=" --batch_size $batch_size --epochs $epochs --backbone $backbone --enc_layers $enc_layers --dec_layers $dec_layers --nheads $nheads --num_queries $num_queries --dim_feedforward $dim_ff --dataset_file $file"
dir=/global/homes/m/marcolz/DETR/gpu_reports/GPU1
pp_dir=/global/homes/m/marcolz/DETR/hgp_detr/roofline-on-nvidia-gpus/custom-scripts
for hidden_dim in 64 128 256 512
do
    output=output_hidden_dim$hidden_dim.txt
    echo hidden_dim: $hidden_dim
    echo "$python --hidden_dim $hidden_dim $args > $dir/txt/$output 2>&1"
    $python --hidden_dim $hidden_dim $args > $dir/txt/$output 2>&1
done
