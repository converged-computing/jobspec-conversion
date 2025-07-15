#!/bin/bash
#FLUX: --job-name=hp_search
#FLUX: --queue=gpu_shared
#FLUX: -t=432000
#FLUX: --priority=16

source activate fluxrgnn
module load 2020
module load CUDA/11.0.2-GCC-9.3.0
module load cuDNN/8.0.3.33-gcccuda-2020a
module load NCCL/2.7.8-gcccuda-2020a
WDIR=$1 # working directory (entry point to data, scripts, models etc.)
OUTPUTDIR=$2 # directory to which grid search results will be written
CONFIGPATH=$3 # hydra config path
HPARAM_FILE=$4 # path to hyperparameter file
TEST_YEAR=$5 # year to hold out in cross-validation
mkdir -p $OUTPUTDIR
rsync $HPARAM_FILE $OUTPUTDIR/
mkdir "$TMPDIR"/data
cp -r $WDIR/data/preprocessed "$TMPDIR"/data
cd $WDIR/scripts
srun python run.py -cp $CONFIGPATH \
  sub_dir=setting_$SLURM_ARRAY_TASK_ID \
  device.root=$TMPDIR \
	datasource.test_year=$TEST_YEAR \
	job_id=$SLURM_ARRAY_TASK_ID \
	output_dir=$OUTPUTDIR \
	$(head -$SLURM_ARRAY_TASK_ID $HPARAM_FILE | tail -1)
