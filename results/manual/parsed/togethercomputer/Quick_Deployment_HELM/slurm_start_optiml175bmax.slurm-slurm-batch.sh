#!/bin/bash
#SBATCH --job-name=together-alpa-OPT-175B
#SBATCH --account=nlp
#SBATCH --output=/afs/cs.stanford.edu/u/biyuan/fm/together/together-accelerate-OPT-iml-175B-max-%j.out
#SBATCH --error=/afs/cs.stanford.edu/u/biyuan/fm/together/together-accelerate-OPT-iml-175B-max-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=a100:8
#SBATCH --mem=12G
#SBATCH --time=01:00:00
#SBATCH --partition=sphinx
#SBATCH --exclude=sphinx[1-3]

cd /nlp/scr2/nlp/fmStore/fm/dev/Quick_Deployment_HELM
nvidia-smi
docker run --rm --gpus '"device=0,1,2,3,4,5,6,7"' --ipc=host -v /nlp/scr2/nlp/fmStore/fm:/home/fm binhang/alpa /home/fm/dev/Quick_Deployment_HELM/start_local_optiml175bmax.sh
