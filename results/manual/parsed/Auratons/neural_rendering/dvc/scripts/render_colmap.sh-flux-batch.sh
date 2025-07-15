#!/bin/bash
#FLUX: --job-name=render
#FLUX: --queue=gpu
#FLUX: -t=18000
#FLUX: --priority=16

export PATH='~/.conda/envs/pipeline/bin:~/.homebrew/bin:${PATH}'

set -e
. /opt/ohpc/admin/lmod/lmod/init/bash
ml purge
module load CUDA/9.1.85
module load cuDNN/7.0.5-CUDA-9.1.85
module load Mesa/18.1.1-fosscuda-2018b
sub=$1
export PATH=~/.conda/envs/pipeline/bin:~/.homebrew/bin:${PATH}
echo
echo "Running on $(hostname)"
echo "The $(type python)"
echo "Interactive Slurm mode GPU index: ${SLURM_STEP_GPUS}"
echo "Batch Slurm mode GPU index: ${SLURM_JOB_GPUS}"
echo
DATASET_PATH=$(cat params.yaml | yq -r '.render_colmap_'$sub'.root')
PLY_FILE=$(cat params.yaml | yq -r '.render_colmap_'$sub'.ply_file')
WORKSPACE=/home/kremeto1/neural_rendering
echo
echo "Running:"
echo "~/.homebrew/bin/time -f 'real\t%e s\nuser\t%U s\nsys\t%S s\nmemmax\t%M kB' python $WORKSPACE/colmap/load_data.py"
echo "    --src_reference=$DATASET_PATH/images"
echo "    --src_colmap=$DATASET_PATH/sparse"
echo "    --ply_path=$DATASET_PATH/$PLY_FILE"
echo "    --src_output=$(cat params.yaml | yq -r '.render_colmap_'$sub'.src_output')"
echo "    --val_ratio=$(cat params.yaml | yq -r '.render_colmap_'$sub'.val_ratio // "0.2"')"
echo "    --point_size=$(cat params.yaml | yq -r '.render_colmap_'$sub'.point_size // "2.0"')"
echo "    --min_size=$(cat params.yaml | yq -r '.render_colmap_'$sub'.min_size // "512"')"
echo "    --voxel_size=$(cat params.yaml | yq -r '.render_colmap_'$sub'.voxel_size')"
echo "    --bg_color=$(cat params.yaml | yq -r '.render_colmap_'$sub'.bg_color // "1,1,1"')"
echo "    --test_size=$(cat params.yaml | yq -r '.render_colmap_'$sub'.test_size // "0"')"
echo "    --squarify=$(cat params.yaml | yq -r '.render_colmap_'$sub'.squarify // "False"')"
echo "    --verbose"
echo
~/.homebrew/bin/time -f 'real\t%e s\nuser\t%U s\nsys\t%S s\nmemmax\t%M kB' singularity \
    exec --nv --bind /nfs:/nfs ~/containers/renderer-app.sif \
        ~/.conda/envs/pipeline/bin/python $WORKSPACE/colmap/load_data.py \
    --src_reference=$DATASET_PATH/images \
    --src_colmap=$DATASET_PATH/sparse \
    --ply_path=$DATASET_PATH/$PLY_FILE \
    --src_output=$(cat params.yaml | yq -r '.render_colmap_'$sub'.src_output') \
    --val_ratio=$(cat params.yaml | yq -r '.render_colmap_'$sub'.val_ratio // "0.2"') \
    --point_size=$(cat params.yaml | yq -r '.render_colmap_'$sub'.point_size // "2.0"') \
    --min_size=$(cat params.yaml | yq -r '.render_colmap_'$sub'.min_size // "512"') \
    --voxel_size=$(cat params.yaml | yq -r '.render_colmap_'$sub'.voxel_size') \
    --bg_color=$(cat params.yaml | yq -r '.render_colmap_'$sub'.bg_color // "1,1,1"') \
    --test_size=$(cat params.yaml | yq -r '.render_colmap_'$sub'.test_size // "0"') \
    --squarify=$(cat params.yaml | yq -r '.render_colmap_'$sub'.squarify // "False"') \
    --verbose
