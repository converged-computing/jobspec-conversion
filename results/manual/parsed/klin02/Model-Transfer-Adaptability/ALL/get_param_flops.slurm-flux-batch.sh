#!/bin/bash
#FLUX: --job-name=stanky-pancake-8933
#FLUX: --urgency=16

echo "Job start at $(date "+%Y-%m-%d %H:%M:%S")"
echo "Job run at:"
echo "$(hostnamectl)"
source /tools/module_env.sh
module list                       # list modules loaded
module load cluster-tools/v1.0
module load slurm-tools/v1.0
module load cmake/3.15.7
module load git/2.17.1
module load vim/8.1.2424
module load python3/3.8.16
module load cuda-cudnn/11.1-8.2.1
echo $(module list)              # list modules loaded
echo $(which gcc)
echo $(which python)
echo $(which python3)
cluster-quota                    # nas quota
nvidia-smi --format=csv --query-gpu=name,driver_version,power.limit # gpu info
echo "Use GPU ${CUDA_VISIBLE_DEVICES}"                              # which gpus
name_list="AlexNet AlexNet_BN VGG_16 VGG_19 Inception_BN ResNet_18 ResNet_50 ResNet_152 MobileNetV2"
for name in $name_list; do 
	if [ -f "param_flops/$Dataset/$name.txt" ];then
		echo "$name: param_flops exists"
	# elif [ ! -f "ckpt/cifar10_$name.pt" ];then
	# 	echo "$name: ckpt not exists"
	else
		python get_param_flops.py $name $Dataset > param_flops/$Dataset/$name.txt
		echo "$name: param_flops done"
	fi
done
echo "Job end at $(date "+%Y-%m-%d %H:%M:%S")"
