#!/bin/bash
#FLUX: --job-name=sticky-avocado-0605
#FLUX: -c=16
#FLUX: -t=1380
#FLUX: --urgency=16

module load arch/avx512 StdEnv/2018.3
nvidia-smi
source venv/bin/activate
curdir=$PWD
datasetdir=${SLURM_TMPDIR}/rsna/
echo "Moving RSNA Dataset to ${datasetdir}"
mkdir -p $datasetdir
time pv ~/scratch/datasets/rsna-intracranial-hemorrhage-detection.tar | tar xf - -C $datasetdir
for iter in 1 2 3
do
    echo "run ${iter}"
    model="resnet101"
    python3 main.py --rsna-base=${datasetdir}rsna-intracranial-hemorrhage-detection \
	    --batch-size=256 --epochs=5 --test-batch-size=128 \
	    --model=${model} --checkpoint=${model}.${iter}.pth --submission=submission.${model}.${iter}.csv \
	    --tb-log=runs/${model}.${iter}
done
