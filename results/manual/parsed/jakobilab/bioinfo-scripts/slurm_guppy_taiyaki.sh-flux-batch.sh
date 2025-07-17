#!/bin/bash
#FLUX: --job-name=conspicuous-buttface-2054
#FLUX: -c=4
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
if [ ! $# == 5 ]; then
  echo "Usage: $0 [Input folder (recursive)] [Output folder] [Kit] [Flow cell type] [model]"
  exit
fi
guppy_basecaller	--qscore_filtering \
                        --trim_strategy 'none'\
			--verbose_logs \
			--compress_fastq \
			--fast5_out \
			-r \
			-i ${1} \
			-s ${2} \
			--flowcell ${4} \
			--kit ${3} \
			--model_file ${5} \
			--num_callers 4 \
			--gpu_runners_per_device 3 \
			--cpu_threads_per_caller 1 \
			--device auto
