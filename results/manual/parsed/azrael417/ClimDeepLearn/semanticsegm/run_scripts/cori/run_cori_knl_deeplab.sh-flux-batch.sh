#!/bin/bash
#FLUX: --job-name=climseg_horovod
#FLUX: --queue=regular
#FLUX: -t=14400
#FLUX: --urgency=16

export OMP_NUM_THREADS='66'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export MKLDNN_VERBOSE='0 #2 is very verbose'

module unload PrgEnv-intel
module load PrgEnv-gnu
module load python/3.6-anaconda-4.4
source activate thorstendl-cori-py3-tf
export OMP_NUM_THREADS=66
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export MKLDNN_VERBOSE=0 #2 is very verbose
datadir=/global/cscratch1/sd/tkurth/gb2018/tiramisu/segm_h5_v3_new_split_maeve
scratchdir=/global/cscratch1/sd/tkurth/temp/deeplab
numfiles_train=100
numfiles_validation=10
numfiles_test=10
run_dir=${WORK}/gb2018/tiramisu/runs/cori/deeplab/run_nnodes${SLURM_NNODES}_j${SLURM_JOBID}
mkdir -p ${run_dir}
cp stage_in_parallel.sh ${run_dir}/
cp ../../utils/parallel_stagein.py ${run_dir}/
cp ../../utils/graph_flops.py ${run_dir}/
cp ../../utils/tracehook.py ${run_dir}/
cp ../../utils/common_helpers.py ${run_dir}/
cp ../../utils/data_helpers.py ${run_dir}/
cp ../../deeplab-tf/deeplab-tf-train.py ${run_dir}/
cp ../../deeplab-tf/deeplab-tf-inference.py ${run_dir}/
cp ../../deeplab-tf/deeplab_model.py ${run_dir}/
cd ${run_dir}
cmd="srun -N ${SLURM_NNODES} -n ${SLURM_NNODES} -c 264 ./stage_in_parallel.sh ${datadir} ${scratchdir} ${numfiles_train} ${numfiles_validation} ${numfiles_test}"
echo ${cmd}
${cmd}
lag=0
train=1
test=0
if [ ${train} -eq 1 ]; then
  echo "Starting Training"
  runid=0
  runfiles=$(ls -latr out.lite.fp32.lag${lag}.train.run* | tail -n1 | awk '{print $9}')
  if [ ! -z ${runfiles} ]; then
      runid=$(echo ${runfiles} | awk '{split($1,a,"run"); print a[1]+1}')
  fi
  python -u ./deeplab-tf-train.py      --datadir_train ${scratchdir}/train \
                                       --train_size ${numfiles_train} \
                                       --datadir_validation ${scratchdir}/validation \
                                       --validation_size ${numfiles_validation} \
                                       --downsampling 2 \
                                       --channels 0 1 2 10 \
                                       --chkpt_dir checkpoint.fp32.lag${lag} \
                                       --epochs 1 \
                                       --fs local \
                                       --loss weighted_mean \
                                       --optimizer opt_type=LARC-Adam,learning_rate=0.0001,gradient_lag=${lag} \
                                       --model=resnet_v2_50 \
                                       --scale_factor 1.0 \
                                       --batch 1 \
                                       --decoder=deconv1x \
                                       --device "/device:cpu:0" \
                                       --label_id 0 \
                                       --disable_imsave \
                                       --tracing="2:5" \
                                       --trace_dir="./" \
                                       --data_format "channels_last" |& tee out.lite.fp32.lag${lag}.train.run${runid}
fi
if [ ${test} -eq 1 ]; then
  echo "Starting Testing"
  runid=0
  runfiles=$(ls -latr out.lite.fp32.lag${lag}.test.run* | tail -n1 | awk '{print $9}')
  if [ ! -z ${runfiles} ]; then
      runid=$(echo ${runfiles} | awk '{split($1,a,"run"); print a[1]+1}')
  fi
  python -u ./deeplab-tf-inference.py      --datadir_test ${scratchdir}/test \
                                           --test_size ${numfiles_test} \
                                           --downsampling 2 \
                                           --channels 0 1 2 10 \
                                           --chkpt_dir checkpoint.fp32.lag${lag} \
                                           --output_graph deepcam_inference.pb \
                                           --output output_test \
                                           --fs local \
                                           --loss weighted_mean \
                                           --model=resnet_v2_50 \
                                           --scale_factor 1.0 \
                                           --batch 1 \
                                           --decoder=deconv1x \
                                           --device "/device:cpu:0" \
                                           --label_id 0 \
                                           --data_format "channels_last" |& tee out.lite.fp32.lag${lag}.test.run${runid}
fi
