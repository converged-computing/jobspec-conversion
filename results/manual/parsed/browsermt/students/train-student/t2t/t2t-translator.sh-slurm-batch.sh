#!/bin/bash
#FLUX: --job-name=t2t
#FLUX: --queue=pascal
#FLUX: -t=129600
#FLUX: --urgency=16

if [[ "$SLURM_JOBID" != "" ]]; then
    module purge
    module load rhel7/default-gpu
    module unload cuda/8.0
    module load python/3.6 cuda/10.0 cudnn/7.5_cuda-10.0
fi
source ~/venv/t2t.2/bin/activate
NBEST=8
ALPHA=1.0
usage(){
  echo "Usage: $0 [options] -M <model> -i <input directory> -d <device>"
  echo -e "\nDetails:\n"
  echo "Required arguments:" 
  echo "-M <model>: 4-letter code: <from><to>, e.g. csen, encs, ..."
  echo "-i <input directory>"
  # echo "-o <output file>"
  echo -e "\nOptional:\n"
  echo "-A <alpha>: t2t alpha parameter (Default: $ALPHA)"
  echo "-N <nbest>: size of n-best list: default is 8, maximum allowed is 16"
  echo "-B <batch size>: default is 256/nbest (assuming 11GB GPU RAM)"
  # echo "-L <logfile>: default is <input file>.log"
  echo "-d <device>: device to use (sets CUDA_VISIBLE_DEVICES)"
}
fail(){
  1>&2 echo "$1. Run with -h for help."
  exit 1
}
while getopts "M:i:N:B:L:A:d:h" o; do
  case $o in
    A) ALPHA=$OPTARG;;
    M) MODEL=$OPTARG;;
    i) IDIR=$OPTARG;;
    N) NBEST=$OPTARG;;
    B) BATCH_SIZE=$OPTARG;;
    # L) LOGFILE=$OPTARG;;
    d) export CUDA_VISIBLE_DEVICES=$OPTARG;;
    [?]) fail "Unknown option $OPTARG.";;
    h) usage; exit 1;;
  esac
done
if [[ "$MODEL" == "" ]]; then fail "No model specified."; fi
if [[ "$NBEST" -gt 32 ]]; then fail "NBEST is unreasonably large (>32)."; fi
MODELDIR=/fs/bil0/bergamot/cuni/models/${MODEL}
LOGFILE=${LOGFILE:-$OUTPUT_FILE.log}
if [[ "$MODEL" == "encs" ]] ; then
  PROBLEM=translate_encs_wmt32k
  ENCODER_LAYERS=12
  BATCH_SIZE=${BATCH_SIZE:-16}
elif [[ "$MODEL" == "csen" ]] ; then
  PROBLEM=translate_encs_wmt32k_rev
  ENCODER_LAYERS=6
  BATCH_SIZE=${BATCH_SIZE:-16}
fi
if [[ -d $IDIR ]]; then
    ifiles=$IDIR/c*.[0-9][0-9][0-9][0-9]
else
  ifiles=$IDIR
fi
for infile in $ifiles; do 
  outfile=$infile.out
  [[ ! -e $outfile ]] || continue
  mkdir ${infile}.lock || continue
  logfile=$infile.log
  opts=(--model=transformer)
  opts+=(--hparams="num_encoder_layers=${ENCODER_LAYERS}")
  opts+=(--problem=$PROBLEM)
  opts+=(--hparams_set=transformer_big_single_gpu)
  opts+=(--data_dir=${MODELDIR})
  opts+=(--output_dir=${MODELDIR})
  opts+=(--decode_hparams="beam_size=$NBEST,alpha=$ALPHA,batch_size=$BATCH_SIZE,return_beams=True")
  opts+=(--decode_from_file=$infile)
  opts+=(--decode_to_file=${outfile}_)
  echo "On host $(hostname)" > $logfile
  echo "t2t-decoder ${opts[@]}" >> $logfile
  t2t-decoder ${opts[@]} 2>> $logfile
  # echo "t2t-decoder ${opts[@]}"
  # t2t-decoder ${opts[@]} 
  succ=$?
  if [[ "$succ" == 0 ]]; then
    mv ${outfile}_ ${outfile}
    rmdir ${infile}.lock
  else
    exit 1
  fi
done
