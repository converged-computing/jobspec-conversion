#!/bin/bash
#SBATCH --job-name=infer
#SBATCH --output=zs_infer_%j.out
#SBATCH --error=zs_infer_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100GB
#SBATCH --time=2-00:00:00

set -x
TRANSFORMER=$1
SENTENCE_TRANSFORMER=$2
BATCH_SIZE=$3
wd=$(pwd)
echo "working directory ${wd}"
SIF=/home/cs.aau.dk/ng78zb/pytorch_23.10-py3.sif
echo "sif ${SIF}"
chmod +x ${wd}
chmod +x ${wd}/infer_zsbert.sh
echo "setting transformer to ${TRANSFORMER} and sentence embedding to ${SENTENCE_TRANSFORMER}"
seeds=(300)
for s in "${seeds[@]}"; do
  srun singularity exec --nv --cleanenv --bind ${wd}:${wd} \
    ${SIF} ${wd}/infer_zsbert.sh ${TRANSFORMER} ${SENTENCE_TRANSFORMER}  ${s} ${BATCH_SIZE}
done
