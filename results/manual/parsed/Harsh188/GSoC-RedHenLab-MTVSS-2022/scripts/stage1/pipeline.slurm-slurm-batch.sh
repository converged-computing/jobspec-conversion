#!/bin/bash
#SBATCH --output=/scratch/users/hxm471/jobs/arrayjob_%A_%a.o
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=30gb
#SBATCH --time=20:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=gpu4v100

module load singularity/3.8.1
cd $TMPDIR
rsync -az hpc3:/mnt/rds/redhen/gallina/home/hxm471/RedHenLab-Multimodal_TV_Show_Segmentation/mtvss $TMPDIR/$USER/
rsync -az hpc3:/mnt/rds/redhen/gallina/home/hxm471/RedHenLab-Multimodal_TV_Show_Segmentation/inaSpeechSegmenter/inaSpeechSegmenter $TMPDIR/$USER/
rsync -az hpc3:/scratch/users/hxm471/model_output $TMPDIR/$USER/
rsync -az hpc3:/mnt/rds/redhen/gallina/home/hxm471/image_dataset $TMPDIR/$USER/
rm -rf $TMPDIR/$USER/image_dataset/unknown
cd $TMPDIR/$USER/
mkdir $TMPDIR/$USER/video_files
mkdir $TMPDIR/$USER/seg
mkdir /scratch/users/$USER/jobs/$SLURM_ARRAY_JOB_ID
mv /scratch/users/$USER/jobs/*_$SLURM_ARRAY_JOB_ID_* /scratch/users/$USER/jobs/$SLURM_ARRAY_JOB_ID
srun singularity exec -e --nv --bind /scratch/users/hxm471/,/home/hxm471/,$TMPDIR/$USER/ /scratch/users/$USER/mtvss_dev6.sif python3 $TMPDIR/$USER/mtvss/pipeline_stage1/run_pipeline_stage1.py --job_num=${SLURM_ARRAY_TASK_ID} --model="music" --verbose=True --file_path=${TMPDIR}/${USER} > /scratch/users/$USER/jobs/$SLURM_ARRAY_JOB_ID/py_output_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.txt
rm -f -r "$TMPDIR"/*
