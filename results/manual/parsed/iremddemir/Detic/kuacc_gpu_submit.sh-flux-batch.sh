#!/bin/bash
#FLUX: --job-name=Test
#FLUX: --queue=ai
#FLUX: -t=86400
#FLUX: --priority=16

echo "Activating Python 3.9.5"
module load python/3.9.5
module load anaconda/3.21.05
module load cuda/11.3
source activate sim_env
echo "Activating GCC-7.2.1..."
module load gcc/7.2.1
echo ""
echo "======================================================================================"
env
echo "======================================================================================"
echo ""
echo "Setting stack size to unlimited..."
ulimit -s unlimited
ulimit -l unlimited
ulimit -a
echo
echo "Running Example Job...!"
echo "==============================================================================="
output_path="../../results/v1/masks.hdf5"
img_dir="../../GQA_ImageSet"
scene_graph="../../scenegraph_generation/results/generated_sg.json"
echo "detectron"
python generate_masks.py detectron2 --img-dir $img_dir --scene-graph $scene-graph  --output $output_path --use-gpu
sleep 60
echo "detic"
python generate_masks.py detic --img-dir $img_dir --scene-graph $scene_graph --output $output_path --use-gpu
sleep 60
echo "detic + custom vocabulary + attributes"
python generate_masks.py detic --img-dir $img_dir --scene-graph $scene_graph --output $output_path --custom-vocabulary --include-attributes --use-gpu
