#!/bin/bash
#SBATCH --output=log/JobName.%J.out
#SBATCH --error=log/JobName.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=96G
#SBATCH --time=4-00:00:00

PREDICT=false
TRACK=false
while getopts :c:f:pt flag
do
    case "${flag}" in
        p) PREDICT=true;;
        t) TRACK=true;;
        c) CONFIG=${OPTARG};;
        f) FOLDER=${OPTARG};;
    esac
done
echo "PREDICT: $PREDICT";
echo "TRACK: $TRACK";
echo "CONFIG: $CONFIG";
echo "FOLDER: $FOLDER";
ENV=OrgaSegment
source ~/.bashrc
cd $SLURM_SUBMIT_DIR
echo $ENV
conda activate $ENV
conda info --envs
nvidia-smi
if [ "$PREDICT" = true ] ; then
    python predict_mrcnn.py $SLURM_JOB_ID $CONFIG $FOLDER
fi
if [ "$TRACK" = true ] ; then
    python track.py $SLURM_JOB_ID $CONFIG $FOLDER
fi
conda deactivate
