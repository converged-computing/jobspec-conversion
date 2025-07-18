#!/bin/bash
#FLUX: --job-name=fwbw-noamp
#FLUX: -t=14400
#FLUX: --urgency=16

export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export HDF5_USE_FILE_LOCKING='FALSE'
export HOROVOD_FUSION_THRESHOLD='0'

do_stage=false
nvalid=0
ntest=0
epochs=1
ntrain=6
batch=1
prec=32
grad_lag=1
scale_factor=0.1
loss_type=weighted #weighted_mean
while (( "$#" )); do
    case "$1" in
        --ntrain)
            ntrain=$2
            shift 2
            ;;
        --nvalid)
            nvalid=$2
            shift 2
            ;;
        --ntest)
            ntest=$2
            shift 2
            ;;
        --epochs)
            epochs=$2
            shift 2
            ;;
        --dummy)
            other_train_opts="--dummy_data"
            shift
            ;;
        -*|--*=)
            echo "Error: Unsupported flag $1" >&2
            exit 1
            ;;
    esac
done
module load tensorflow/gpu-1.15.0-py37
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export HDF5_USE_FILE_LOCKING=FALSE
datadir=/global/cfs/cdirs/nstaff/cjyang/study/cudatut/me/climate-seg-benchmark/data/climseg-data-duplicated
out_dir=$SCRATCH/climate-seg-benchmark/run_cgpu_job${SLURM_JOBID}/
run_dir=${out_dir}
mkdir -p ${out_dir}
script_dir=/global/cfs/cdirs/nstaff/cjyang/study/Yunsong/climate-seg-benchmark/run_scripts
cp ${script_dir}/stage_in_parallel.sh ${run_dir}/
cp ${script_dir}/../utils/parallel_stagein.py ${run_dir}/
cp ${script_dir}/../utils/graph_flops.py ${run_dir}/
cp ${script_dir}/../utils/tracehook.py ${run_dir}/
cp ${script_dir}/../utils/common_helpers.py ${run_dir}/
cp ${script_dir}/../utils/data_helpers.py ${run_dir}/
cp ${script_dir}/../deeplab-tf/deeplab-tf-train.py ${run_dir}/
cp ${script_dir}/../deeplab-tf/deeplab-tf-inference.py ${run_dir}/
cp ${script_dir}/../deeplab-tf/deeplab_model.py ${run_dir}/
cp $0 ${run_dir}/script.fwbw.noamp.sh
cd ${run_dir}
sed -e '/enable_mixed_precision_graph_rewrite/ s/^#*/#/' -i common_helpers.py
metrics="sm__cycles_elapsed.avg.per_second \
sm__cycles_elapsed.avg \
sm__inst_executed_pipe_tensor.sum \
sm__sass_thread_inst_executed_op_fadd_pred_on.sum \
sm__sass_thread_inst_executed_op_ffma_pred_on.sum \
sm__sass_thread_inst_executed_op_fmul_pred_on.sum \
sm__sass_thread_inst_executed_op_hadd_pred_on.sum \
sm__sass_thread_inst_executed_op_hfma_pred_on.sum \
sm__sass_thread_inst_executed_op_hmul_pred_on.sum \
dram__bytes.sum \
lts__t_bytes.sum \
l1tex__t_bytes.sum "
which nvcc
which nv-nsight-cu-cli
which python
export HOROVOD_FUSION_THRESHOLD=0
for metric in ${metrics}; do
profilestring="/project/projectdirs/m1759/nsight-compute-2020.1.0.20/nv-nsight-cu-cli --profile-from-start off --metrics ${metric} --csv --kernel-base demangled"
if [ $ntrain -ne 0 ]; then
    echo "Starting Training"
    srun -n1 -u ${profilestring} `which python` -u deeplab-tf-train.py \
        --datadir_train ${datadir}/train \
        --train_size ${ntrain} \
        --validation_size ${nvalid} \
        --datadir_validation ${datadir}/validation \
        --disable_checkpoint \
        --epochs $epochs \
        --fs "global" \
        --loss $loss_type \
        --optimizer opt_type=LARC-Adam,learning_rate=0.0001,gradient_lag=${grad_lag} \
        --model "resnet_v2_50" \
        --scale_factor $scale_factor \
        --batch $batch \
        --decoder "deconv1x" \
        --device "/device:cpu:0" \
        --dtype "float${prec}" \
        --label_id 0 \
        --data_format "channels_first" \
        --use_batchnorm \
        --disable_imsave \
        $other_train_opts 2>&1 > out.fp${prec}.lag${grad_lag}.train.${metric}
fi
done 
