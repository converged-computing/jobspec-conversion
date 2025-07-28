#!/bin/bash
#FLUX: --job-name=run_faceswap
#FLUX: --queue=gtx1080
#FLUX: -t=25200
#FLUX: --urgency=16

echo "SLURM_JOBID"=$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
module load anaconda                          ### load anaconda module
source activate py37                          ### activating environment, environment must be configured before running the job
mkdir Project
mkdir Project/faceA
mkdir faceSwapProject/faceA
mkdir faceSwapProject/modelAB
mkdir faceSwapProject/TimelapseAB
python ../faceswap/faceswap.py extract -i Project/src/faceA.mp4 -o Project/faceA -D s3fd -A fan 
python ../faceswap/faceswap.py extract -i Project/src/faceB.mp4 -o Project/faceB -D s3fd -A fan 
python ../faceswap/faceswap.py train -A Project/faceA -ala Project/src/faceA_alignments.fsa -alb Project/src/faceB_alignments.fsa -B Project/faceB -m Project/ModelAB -t original -tia Project/faceA -tib Project/faceB -to Project/TimelapseAB
python ../faceswap/faceswap.py convert -i Project/src/faceA.mp4 -o Project -m Project/ModelAB -c match-hist -M extended -w ffmpeg 
