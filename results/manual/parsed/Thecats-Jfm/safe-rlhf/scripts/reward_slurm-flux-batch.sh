#!/bin/bash
#FLUX: --job-name=rlhf_rm
#FLUX: -N=2
#FLUX: --queue=gpu
#FLUX: -t=144000
#FLUX: --urgency=16

export NCCL_IB_HCA='mlx5_0:1,mlx5_1:1,mlx5_4:1,mlx5_5:1'
export NCCL_IB_DISABLE='0'
export NCCL_SOCKET_IFNAME='bond0'
export NCCL_DEBUG='INFO'
export WANDB_MODE='offline'
export PYTHONPATH='${ROOT_DIR}${PYTHONPATH:+:${PYTHONPATH}}'
export LOGLEVEL='${LOGLEVEL:-WARNING}'

module load anaconda/2023.03
module load cuda/11.8
source activate safe-rlhf
export NCCL_IB_HCA=mlx5_0:1,mlx5_1:1,mlx5_4:1,mlx5_5:1
export NCCL_IB_DISABLE=0
export NCCL_SOCKET_IFNAME=bond0
export NCCL_DEBUG=INFO
export WANDB_MODE="offline"
if [ -z "${BASH_VERSION}" ]; then
	echo "Please use bash to run this script." >&2
	exit 1
fi
set -x
SCRIPT_DIR="$(cd "$(dirname "$0")" &>/dev/null && pwd)"
ROOT_DIR="$(dirname "${SCRIPT_DIR}")"
export PYTHONPATH="${ROOT_DIR}${PYTHONPATH:+:${PYTHONPATH}}"
export LOGLEVEL="${LOGLEVEL:-WARNING}"
ZERO_STAGE=3
while [[ "$#" -gt 0 ]]; do
	arg="$1"
	shift
	case "${arg}" in
		--model_name_or_path)
			MODEL_NAME_OR_PATH="$1"
			shift
			;;
		--model_name_or_path=*)
			MODEL_NAME_OR_PATH="${arg#*=}"
			;;
		--output_dir)
			OUTPUT_DIR="$1"
			shift
			;;
		--output_dir=*)
			OUTPUT_DIR="${arg#*=}"
			;;
		--zero_stage)
			ZERO_STAGE="$1"
			shift
			;;
		--zero_stage=*)
			ZERO_STAGE="${arg#*=}"
			;;
		*)
			echo "Unknown parameter passed: '${arg}'" >&2
			exit 1
			;;
	esac
done
mkdir -p "${OUTPUT_DIR}"
OUTPUT_DIR="$(cd "${OUTPUT_DIR}" &>/dev/null && pwd)"
if [[ ! -f "${OUTPUT_DIR}/.gitignore" ]]; then
	echo '*' >"${OUTPUT_DIR}/.gitignore"
fi
cp -f "$0" "${OUTPUT_DIR}/script.sh"
if [[ -z "${WANDB_API_KEY}" ]]; then
	export WANDB_MODE="offline"
fi
MASTER_PORT_START=10000
MASTER_PORT_END=65535
MASTER_PORT="$(
	comm -23 \
		<(seq "${MASTER_PORT_START}" "${MASTER_PORT_END}" | sort) \
		<(ss -Htan | awk '{ print $4 }' | awk -F ':' '{ print $NF }' | sort -u) |
		shuf | head -n 1
)"
exec 1> >(tee "${OUTPUT_DIR}/stdout.log" >&1) 2> >(tee "${OUTPUT_DIR}/stderr.log" >&2)
deepspeed --hostfile scripts/hostfile.txt \
	--master_port "${MASTER_PORT}" \
	--module safe_rlhf.values.reward \
	--train_datasets joyland-pair/catV4_train:0.1 \
	--eval_datasets joyland-pair/catV4_val:0.1 \
	--model_name_or_path "${MODEL_NAME_OR_PATH}" \
	--max_length 4096 \
	--trust_remote_code True \
	--loss_type sequence-wise \
	--epochs 1 \
	--regularization 0.001 \
	--per_device_train_batch_size 1 \
	--per_device_eval_batch_size 1 \
	--gradient_accumulation_steps 16 \
	--gradient_checkpointing \
	--normalize_score_during_training False \
	--normalizer_type ExponentialMovingAverage \
	--normalizer_momentum 0.9 \
	--learning_rate 1e-5 \
	--lr_scheduler_type cosine \
	--lr_warmup_ratio 0.03 \
	--weight_decay 0.1 \
	--seed 42 \
	--need_eval \
	--eval_strategy steps \
	--eval_interval 350 \
	--output_dir "${OUTPUT_DIR}" \
	--log_type wandb \
	--log_project Safe-RLHF-RM \
	--zero_stage "${ZERO_STAGE}" \
	--bf16 True \
	--tf32 True
