#!/bin/bash
#FLUX: --job-name=conv2d_test
#FLUX: --exclusive
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_NUM_THREADS='$(( 40 / ${rankspernode} ))'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

module unload cuda
module load cuda/10.1.243
module load python/3.7-anaconda-2019.07
source activate thorstendl-gori-py3-tf2
rankspernode=1
export OMP_NUM_THREADS=$(( 40 / ${rankspernode} ))
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
sruncmd="srun -N ${SLURM_NNODES} -n $(( ${SLURM_NNODES} * ${rankspernode} )) -c $(( 80 / ${rankspernode} )) --cpu_bind=cores"
run_dir=$WORK/tf_cnn_kernels_2/runs/${SLURM_JOBID}
mkdir -p ${run_dir}
cp conv2d_v2.py ${run_dir}/
prec=16
batch_size=32
data_format="NHWC"
net_params="VGG-1,224x224x3,3x3x3x64,1 ResNet50-1,224x224x3,7x7x3x64,2 VGG-2,224x224x64,3x3x64x128,2 VGG-3,112x112x128,3x3x128x256,2 ResNet50-2,112x112x64,3x3x64x64,2"
cd ${run_dir}
metrics="time tensor_precision_fu_utilization flop_count_hp flop_count_sp sysmem_read_transactions sysmem_write_transactions dram_read_transactions dram_write_transactions l2_read_transactions l2_write_transactions gld_transactions gst_transactions shared_load_transactions shared_store_transactions atomic_transactions"
for metric in ${metrics}; do
    #iterate over input tuples
    for input in ${net_params}; do 
        OLDIFS=$IFS; IFS=','
        set -- $input; 
        name=$1
        input_tensor_shape=${2//x/ }
        kernel_shape=${3//x/ }
        stride=${4}
        IFS=${OLDIFS}
        #iterate over FW BW
        for ctype in calibrate forward backward; do
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
            ${sruncmd} ${profilestring} $(which python) -u ./conv2d_v2.py \
                --dtype float${prec} \
                --data_format ${data_format} \
                --input_tensor_shape ${batch_size} ${input_tensor_shape} \
                --kernel_shape ${kernel_shape} \
                --stride ${stride} \
                --num_warmups 5 \
                --num_iterations 20 \
                --compute_type ${ctype}
        done
    done
done
