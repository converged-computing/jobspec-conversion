#!/bin/bash
#FLUX: --job-name=ornery-cat-6730
#FLUX: --queue=broadwl
#FLUX: -t=90000
#FLUX: --urgency=16

BASE_DIR=$(pwd)
DATE=$(date "+%Y_%m_%d")
echo $DATE
rent=true
n=1
input=armi
config=config_nml.nml
while [ $# -gt 0 ]; do
    case "$1" in
    --armi)
      input=armi
      ;;
    --frmi)
      input=frmi
      ;;
    --norent)
      rent=false
      ;;
    --n)
      shift
      n=$1
      ;;
    --model_id)
      shift
      model_id="${1}"
      ;;
    --config)
      shift
      config="${1}"
      ;;
    -*)
      # do not exit out, just note failure
      error_msg "unrecognized option: $1"
      ;;
    *)
      break;
      ;;
    esac
    shift
done
echo "input: ${input}, rent: ${rent}, model_id: ${model_id}, n: ${n}"
echo "BASE_DIR: ${BASE_DIR}, config: ${config}"
if [ "$rent" = true ]; then
  ./compile_code.sh renti $config
fi
./compile_code.sh $input $config
model_dir="$SCRATCH/run/${model_id}_${DATE}"
mkdir $model_dir
cd $model_dir
cp $BASE_DIR/src/${config} .
cp $BASE_DIR/src/renti  .
cp $BASE_DIR/src/${input}  .
cp $BASE_DIR/src/matlab/*.m  .
if [ "$rent" = true ]; then
  echo "Running renti"
  ./renti > renti.out
fi
echo "Running $input"
./${input} > ${input}.out
sbatch $BASE_DIR/matlab_batch.sbatch $input $model_id $n
