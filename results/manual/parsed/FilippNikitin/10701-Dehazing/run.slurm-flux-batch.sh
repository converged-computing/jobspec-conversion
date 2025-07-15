#!/bin/bash
#FLUX: --job-name=adorable-kitty-6844
#FLUX: --queue=dept_gpu
#FLUX: --priority=16

echo Running on `hostname`
echo workdir $PBS_O_WORKDIR
cd $SLURM_SUBMIT_DIR
SCRDIR=/scr/${SLURM_JOB_ID}
if [[ ! -e $SCRDIR ]]; then
        mkdir $SCRDIR
fi
chmod +rX $SCRDIR
echo scratch drive ${SCRDIR}
rsync -rv -q $SLURM_SUBMIT_DIR/ ${SCRDIR}
if [[ -e $SCRDIR/saved_models ]]; then
        rm -rf $SCRDIR/saved_models
fi
cd ${SCRDIR}
module load cuda
conda run --live-stream -n pt1102 python -u lightning.py configs/hrtransformer.yaml
rsync -rv -q $SCRDIR/ $SLURM_SUBMIT_DIR
rm -rf ${SCRDIR}
