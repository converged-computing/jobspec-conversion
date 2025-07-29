#!/bin/bash
#SBATCH --job-name=baseline
#SBATCH --account=iict-sp2.volk.cl.uzh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00

VIDEO=${1:-'~/pose-pipelines/example.mp4'}
OUTPUT=${2:-'~/pose-pipelines/example.openpose/'}
module load t4
module load singularityce
module load cudnn/7.6.5.32-10.2
srun singularity exec \
-B /data -B /scratch \
-B /net/cephfs/data \
-B /net/cephfs/scratch \
--nv \
--pwd /openpose/ \
~/data/openpose_latest \
./build/examples/openpose/openpose.bin --video $VIDEO --write_json $OUTPUT --display 0 --face --hand --render_pose 0
