#!/bin/bash
#FLUX: --job-name=crusty-pedo-8415
#FLUX: --queue=gpu
#FLUX: --urgency=16

echo "==== Start of GPU information ===="
CUDA_DEVICE=$(echo "$CUDA_VISIBLE_DEVICES," | cut -d',' -f $((SLURM_LOCALID + 1)) );
T_REGEX='^[0-9]$';
if ! [[ "$CUDA_DEVICE" =~ $T_REGEX ]]; then
        echo "error no reserved gpu provided"
        exit 1;
fi
echo -e "SLURM job:\t$SLURM_JOBID"
echo -e "CUDA_VISIBLE_DEVICES:\t$CUDA_VISIBLE_DEVICES"
echo "Device list:"
echo "$(nvidia-smi --query-gpu=name,gpu_uuid --format=csv -i $CUDA_VISIBLE_DEVICES | tail -n +2)"
echo "==== End of GPU information ===="
echo ""
module load guppy
if [ ! $# == 4 ]; then
  echo "Usage: $0 [Input folder (recursive)] [Output folder] [Kit] [Flow cell type]"
  exit
fi
guppy_basecaller	--trim_strategy none\
			--verbose_logs \
			--compress_fastq \
			--fast5_out \
			-r \
			-i ${1} \
			-s ${2} \
			--num_callers 4 \
                        --chunks_per_runner 768 \
                        --chunk_size 500 \
			--gpu_runners_per_device 8 \
			--cpu_threads_per_caller 10 \
			--device auto \
                        --flowcell ${4} \
                        --kit ${3}
