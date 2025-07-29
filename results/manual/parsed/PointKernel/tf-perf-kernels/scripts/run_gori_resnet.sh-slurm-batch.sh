#!/bin/bash
#FLUX: --job-name=conv2d_test
#FLUX: --exclusive
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_NUM_THREADS='$(( 40 / ${rankspernode} ))'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

module unload cuda
module load cuda/10.0.130
module load python/3.6-anaconda-4.4
source activate thorstendl-gori-py3-tf
rankspernode=1
export OMP_NUM_THREADS=$(( 40 / ${rankspernode} ))
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
sruncmd="srun -N ${SLURM_NNODES} -n $(( ${SLURM_NNODES} * ${rankspernode} )) -c $(( 80 / ${rankspernode} )) --cpu_bind=cores"
run_dir=$WORK/tf_cnn_kernels_2/runs/${SLURM_JOBID}
mkdir -p ${run_dir}
cp resnet.py ${run_dir}/
prec=16
batch_size=16
data_format="NHWC"
net_params="ResNet50,224x224x3,100,16"
cd ${run_dir}
metrics="time"
for metric in ${metrics}; do
    #iterate over input tuples
    for input in ${net_params}; do 
        OLDIFS=$IFS; IFS=','
        set -- $input; 
        name=$1
        input_tensor_shape=${2//x/ }
        num_classes=${3//x/ }
        stride=${4}
        IFS=${OLDIFS}
        #iterate over FW BW
        for ctype in forward calibrate forward backward; do
            #get better metric name
            metricname=${metric//,/-}
            #assemble profiling string
            if [ "${metric}" == "time" ]; then
                profilestring="nvprof --profile-from-start off"
            else
                profilestring="nvprof --profile-from-start off --metrics ${metric}"
            fi
            profilestring=${profilestring}" -f -o profile.name_${name}.batchsize_${batch_size}.inputshape_${2}.kernelshape_${3}.stride_${4}.dataformat_${data_format}.fp${prec}.pass_${ctype}.metric_${metricname}.nvvp"
            #profilestring=""
            #compute types
            ${sruncmd} ${profilestring} $(which python) -u ./resnet.py \
                --dtype float${prec} \
                --data_format ${data_format} \
                --input_tensor_shape ${batch_size} ${input_tensor_shape} \
                --num_classes ${num_classes} \
                --num_warmups 5 \
                --num_iterations 20 \
                --compute_type ${ctype}
            break
        done
    done
done
