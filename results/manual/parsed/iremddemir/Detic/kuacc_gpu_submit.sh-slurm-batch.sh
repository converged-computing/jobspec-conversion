#!/bin/bash
#SBATCH --job-name=Test
#SBATCH --account=ai
#SBATCH --output=test-%j.out
#SBATCH --mail-user=idemir18@ku.edu.tr
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=5G
#SBATCH --time=1-00:00:00
#SBATCH --partition=ai
#SBATCH --constraint=ntasks-per-node=2,tesla_t4|tesla_k80

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
