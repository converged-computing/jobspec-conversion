#!/bin/bash
#FLUX: --job-name=${job_name}
#FLUX: -c=4
#FLUX: --urgency=16

export WANDB_API_KEY='$WANDB_API_KEY'

patient_id="$1"
model_id="$2"
datetime_id="$3"
epochs="$4"
project_id="$5"
split="$6"
classify="$7"
exp_id="$8"
pretrained_datetime_id="$9"
requires_grad="${10}"
transfer_id="${11}"
data_size="${12}"
echo "Patient ID: ${patient_id}"
echo "Model ID: downstream3"
echo "Datetime ID: ${datetime_id}"
echo "Epochs: ${epochs}"
echo "Project ID: ${project_id}"
echo "Split: ${split}"
echo "Classify: ${classify}"
echo "Experiment ID: ${exp_id}"
echo "Pretrained Datetime ID: ${pretrained_datetime_id}"
echo "Requires Grad: ${requires_grad}"
echo "Transfer ID: ${transfer_id}"
echo "Data Size: ${data_size}"
time="00:25:00"
base_dir="${xav}/ssl_epilepsy/models/${patient_id}"
mkdir -p "${base_dir}" || { echo "Error: Cannot create directory ${base_dir}"; exit 1; }
logdir="${base_dir}/${model_id}/${datetime_id}"
mkdir -p "${logdir}" || { echo "Error: Cannot create directory ${logdir}"; exit 1; }
data_path="${xav}/ssl_epilepsy/data/patient_pyg/${patient_id}/supervised"
model_path="${xav}/ssl_epilepsy/models/${patient_id}/${transfer_id}/${pretrained_datetime_id}/model/${transfer_id}.pth"
model_dict_path="${xav}/ssl_epilepsy/models/${patient_id}/${transfer_id}/${pretrained_datetime_id}/model/${transfer_id}_state_dict.pth"
job_name="transfer_anyGPU_${patient_id}_${model_id}_${transfer_id}_${pretrained_datetime_id}_${datetime_id}"
run_type="all"
echo "Preparing to submit downstream3 training job..."
sbatch <<EOT
cd "${xav}/ssl_epilepsy/ssl-seizure-detection/src"
module load cuda/11.7 cudnn/8.9.5.29 python/3.10
source ~/torch2_cuda11.7/bin/activate
python main.py "${data_path}" "${logdir}" "${patient_id}" \
"${model_id}" "${datetime_id}" "${run_type}" "${classify}" \
"${split}" "${epochs}" "${project_id}" "${exp_id}" "${data_size}" \
"${model_path}" "${model_dict_path}" "${transfer_id}" "${requires_grad}"
EOT
if [ $? -ne 0 ]; then
echo "Error: sbatch submission failed."
exit 1
fi
echo "Job submission complete."
