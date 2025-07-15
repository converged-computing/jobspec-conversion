#!/bin/bash
#FLUX: --job-name=run
#FLUX: -c=16
#FLUX: -t=85800
#FLUX: --priority=16

echo ---------- MAIN SCRIPT ----------
echo hostname=$(hostname)
echo nproc=$(nproc)
echo CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES
echo ---------------------------------
module purge
module load intel/2019.4
module load python/3.6.8
module load cuda/9.2
echo ---------------------------------
DEBUG='echo hostname=$(hostname) nproc=$(nproc) CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES
python3 -c "import torch; torch.randn(1000,1000,100).cuda(); import time; time.sleep(5)"'
SRUN_PARAMS='--exclusive --cpus-per-task=8 --mem-per-cpu=1625M --ntasks=1 --nodes=1'
ML_PARAMS="--func shallow_hpo --n_iter 1000 --epochs 500 --patience 20 --target press"
BINARY_PARAMS="--encoding binary --step 10 --resample_once "
MULTICLASS_PARAMS="--encoding multiclass --step 1"
declare -A CMD_ARRAY
CMD_ARRAY=(
	['0']=${DEBUG}
	['1']="python3  -m ml crnn     ${ML_PARAMS} ${BINARY_PARAMS} --seg_width 35"
	['2']="python3  -m ml wavenet  ${ML_PARAMS} ${BINARY_PARAMS} --seg_width 35"
	['3']="python3  -m ml resnet   ${ML_PARAMS} ${BINARY_PARAMS} --seg_width 35"
	['4']="python3  -m ml resnet11 ${ML_PARAMS} ${BINARY_PARAMS} --seg_width 35"
	['5']="python3  -m ml crnn     ${ML_PARAMS} ${MULTICLASS_PARAMS} --seg_width 35"
	['6']="python3  -m ml wavenet  ${ML_PARAMS} ${MULTICLASS_PARAMS} --seg_width 35"
	['7']="python3  -m ml resnet   ${ML_PARAMS} ${MULTICLASS_PARAMS} --seg_width 35"
	['8']="python3  -m ml resnet11 ${ML_PARAMS} ${MULTICLASS_PARAMS} --seg_width 35"
	['9']="python3  -m ml crnn     ${ML_PARAMS} ${BINARY_PARAMS} --seg_width 45"
	['10']="python3 -m ml wavenet  ${ML_PARAMS} ${BINARY_PARAMS} --seg_width 45"
	['11']="python3 -m ml resnet   ${ML_PARAMS} ${BINARY_PARAMS} --seg_width 45"
	['12']="python3 -m ml resnet11 ${ML_PARAMS} ${BINARY_PARAMS} --seg_width 45"
	['13']="python3 -m ml crnn     ${ML_PARAMS} ${MULTICLASS_PARAMS} --seg_width 45"
	['14']="python3 -m ml wavenet  ${ML_PARAMS} ${MULTICLASS_PARAMS} --seg_width 45"
	['15']="python3 -m ml resnet   ${ML_PARAMS} ${MULTICLASS_PARAMS} --seg_width 45"
	['16']="python3 -m ml resnet11 ${ML_PARAMS} ${MULTICLASS_PARAMS} --seg_width 45"
)
for i in {0..1}
do
	CMD="${CMD_ARRAY[${SLURM_ARRAY_TASK_ID}]} --uid ${SLURM_ARRAY_TASK_ID}_${i}"
	echo ${CMD}
	CUDA_VISIBLE_DEVICES=${i} srun ${SRUN_PARAMS} bash -c "${CMD}" 2>&1 | sed -u 's/^/GPU '${i}': /' &
done
if [ ${SLURM_ARRAY_TASK_ID} -eq '0' ]
then
	sleep 8
	ps -aux | grep python3
	nvidia-smi
fi
wait
echo "Execution done"
