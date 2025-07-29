#!/bin/bash
#FLUX: --job-name=pack_perception
#FLUX: -c=8
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

export BRT_ENV='prod'
export AWS_DEFAULT_REGION='us-west-2'
export CUDA_DEVICE_ORDER='PCI_BUS_ID'
export WANDB_MODE='offline'
export PYTHONUNBUFFERED='1'

DATA_FOLDER=/data2/jupiter/datasets
DATASET_NAME=on_path_aft_humans_night_2024_rev2_v2
JUPITERCVML_DIR=~/git/JupiterCVML
RESUME_MODE=existing
set -e
module load anaconda singularity
conda activate /mnt/sandbox1/anirudh.vegesana/conda_envs/pp/
pip install --user numpy-quaternion
export BRT_ENV=prod
export AWS_DEFAULT_REGION=us-west-2
export CUDA_DEVICE_ORDER=PCI_BUS_ID
export WANDB_MODE=offline
export PYTHONUNBUFFERED=1
if [ -n "$JUPITERCVML_DIR" ]
then
    EUROPA_DIR=$JUPITERCVML_DIR/europa/base/src/europa/
    export PYTHONPATH=$EUROPA_DIR:$PYTHONPATH
    FILES_DIR=$JUPITERCVML_DIR/europa/base/files/
    EXECUTABLES_DIR=$JUPITERCVML_DIR/europa/base/executables
    _ADDITIONAL_BINDS=$_ADDITIONAL_BINDS,$EUROPA_DIR:/src/europa,$FILES_DIR:/files,$EXECUTABLES_DIR:/executables
    DOWNLOAD_DATASET_CMD="python3 $EUROPA_DIR/dl/dataset/download.py"
    PARITION_DATASET_CMD="python3 $EUROPA_DIR/dl/dataset/pack_perception/partition_dataset.py"
else
    DOWNLOAD_DATASET_CMD=/data2/jupiter/jupiter_npz_model_training_kore_jup_tolerations
    PARITION_DATASET_CMD=/data2/jupiter/partition_dataset
fi
DATA=$DATA_FOLDER/$DATASET_NAME
NUM_PARTITIONS=$SLURM_NTASKS
if [ ! -f "$DATA" ]
then
    $DOWNLOAD_DATASET_CMD $DATASET_NAME -d $DATA_FOLDER
fi
if [ ! -f "$DATA/online_calibration_data/images" ]
then
    mkdir -p $DATA/online_calibration_data/images
    if [ -n "$JUPITERCVML_DIR" ]
    then
        python3 $EUROPA_DIR/dl/dataset/pack_perception/download_ocal_data.py $DATA
    fi
fi
set +e
if [ -n "$SLURM_RESTART_COUNT" ] && [ $SLURM_RESTART_COUNT -ne 0 ]
then
    echo SLURM reset. Ignoring resume mode and continuing run.
elif [ "$RESUME_MODE" = "fresh" ]
then
    echo Deleting existing partitions.
    rm -r \
        $DATA/partitions \
        $DATA/processed \
        $DATA/master_annotations.csv
elif [ "$RESUME_MODE" = "redo-ocal" ]
then
    echo Deleting ocal results.
    rm -r \
        $DATA/partitions/*/master_annotations.csv \
        $DATA/partitions/*/annotations_ocal.csv \
        $DATA/partitions/*/online_calibration_data/ocal_df.csv \
        $DATA/processed \
        $DATA/master_annotations.csv
elif [ "$RESUME_MODE" = "redo-depth" ]
then
    echo Deleting depth inference results.
    rm -r \
        $DATA/partitions/*/master_annotations.csv \
        $DATA/processed \
        $DATA/master_annotations.csv
elif [ "$RESUME_MODE" = "existing" ]
then
    if [ -f "$DATA/partitions" ]
    then
        echo Resuming existing PP run.
    else
        echo Starting new PP run.
    fi
else
    echo Unknown resume mode $RESUME_MODE. Using existing.
fi
set -e
mkdir -p $DATA/processed
if [ -n "$JUPITERCVML_DIR" -a ! -f "$DATA/processed/calibration" ]
then
    cp -r $FILES_DIR/calibration $DATA/processed/
fi
if [ ! -f "$DATA/partitions" ]
then
    $PARITION_DATASET_CMD \
        --dataset-folder $DATA \
        --partitions-folder $DATA/partitions \
        --num-partitions $NUM_PARTITIONS \
        partition \
        --use-relative-symlinks false
else
    echo Using existing partitioning.
    $PARITION_DATASET_CMD \
        --dataset-folder $DATA \
        --partitions-folder $DATA/partitions \
        --num-partitions $NUM_PARTITIONS \
        verify
fi
srun --kill-on-bad-exit \
    --output=/mnt/sandbox1/%u/logs/%j_%x.batch.txt \
    --error=/mnt/sandbox1/%u/logs/%j_%x.batch.txt \
    --unbuffered \
singularity run \
    --nv --bind /data,/data2$_ADDITIONAL_BINDS \
    /data2/jupiter/singularity/jupiter-pack-perception/libs_halo_kf-cvml_master.sif \
python3 -m dl.dataset.pack_perception.ml_pack_perception \
    --data-dir $DATA/partitions/\$SLURM_PROCID --csv-path \\\$DATA_DIR/annotations.csv \
    --calib-tracker-csv /files/calibration/motec_calibration_tracker_2019.csv \
    --cam-calibration-path /files/calibration --ignore-slurm-variables \
    --batch-size 24 --multiprocess-workers 24 --pandarallel-workers 24 --gpu 0 \
    --models 512,768=depth_full_finetuned_512x768_Jan25_2024_fixed.ptp \
             512,640=depth_full_finetuned_512x640_Jan25_2024_fixed.ptp \
    --model-type full --max-disp 384 \
    --run-oc \
    # --image-only \
    # --full-res \
$PARITION_DATASET_CMD \
    --dataset-folder $DATA \
    --partitions-folder $DATA/partitions \
    --num-partitions $NUM_PARTITIONS \
    combine
