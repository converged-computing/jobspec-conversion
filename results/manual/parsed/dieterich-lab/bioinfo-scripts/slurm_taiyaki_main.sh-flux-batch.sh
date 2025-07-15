#!/bin/bash
#FLUX: --job-name=psycho-ricecake-7688
#FLUX: --priority=16

module unload cuda
echo "==== Start of GPU information ===="
CUDA_DEVICE=$(echo "$CUDA_VISIBLE_DEVICES," | cut -d',' -f $((SLURM_LOCALID + 1)) );
T_REGEX='^[0-9]$';
if ! [[ "$CUDA_DEVICE" =~ $T_REGEX ]]; then
        echo "error no reserved gpu provided"
        exit 1;
fi
echo -e "SLURM job:\t$SLURM_JOBID"
echo -e "SLURM process:\t$SLURM_PROCID"
echo -e "SLURM GPU ID:\t$SLURM_LOCALID"
echo -e "CUDA_DEVICE ID:\t$CUDA_DEVICE"
echo -e "CUDA_VISIBLE_DEVICES:\t$CUDA_VISIBLE_DEVICES"
echo "Device list:"
echo "$(nvidia-smi --query-gpu=name,gpu_uuid --format=csv -i $CUDA_VISIBLE_DEVICES | tail -n +2)"
echo "==== End of GPU information ===="
echo ""
module load taiyaki
if [ ! $# == 4 ]; then
  echo "Usage: $0 [Read directory (FAST5)] [target dir e.g. /tmp/] [pretrained model] [FASTA read training set]"
  exit
fi
reads=$1
out=$2
pretrained_model=$3
fasta_file=$4
CUDA_VISIBLE_DEVICES=0
mkdir $out -pv
echo "======== generate per read params"
time generate_per_read_params.py --jobs 10 $reads > $out/modbase.tsv
echo "======== prepare mapped reads"
time prepare_mapped_reads.py --jobs 10 --overwrite --alphabet ACGT --mod Y A 6mA $reads $out/modbase.tsv $out/modbase.hdf5 $pretrained_model $fasta_file
echo "======== training1"
time train_flipflop.py --full_filter_status --overwrite --device $CUDA_VISIBLE_DEVICES --chunk_len_min 2000 --chunk_len_max 4000 --size 256 --stride 10 --winlen 31 --mod_factor 0.01 --outdir $out/training /biosw/taiyaki/5.0.1/models/mGru_cat_mod_flipflop.py $out/modbase.hdf5
echo "======== training2"
time train_flipflop.py --full_filter_status --overwrite --device $CUDA_VISIBLE_DEVICES --chunk_len_min 2000 --chunk_len_max 4000 --size 256 --stride 10 --winlen 31 --mod_factor 0.1 --outdir $out/training2 $out/training/model_final.checkpoint $out/modbase.hdf5
echo "======== basecall"
time basecall.py --alphabet ACGT --device $CUDA_VISIBLE_DEVICES --modified_base_output $out/basecalls.hdf5 $reads $out/training2/model_final.checkpoint  > $out/basecalls.fa
