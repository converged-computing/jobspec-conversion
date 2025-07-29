#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=40g
#SBATCH --time=03:00:00
#SBATCH --partition=gpu

module load cuda
echo Master process running on `hostname`
echo Directory is `pwd`
echo Starting execution at `date`
echo Current PATH is $PATH
cd scripts 
singularity exec -B /oscar/scratch,/oscar/data/ /users/czhan157/wireframe_testing/docker/singularity1.simg python3 test.py  --config-file ../config-files/layout-SRW-S3D.yaml --img-folder ../wireframe_data/wireframe_testing CHECKPOINT ../data/model_proposal_s3d.pth GNN_CHECKPOINT ../data/model_gnn_s3d.pth OUTPUT_DIR ../results
