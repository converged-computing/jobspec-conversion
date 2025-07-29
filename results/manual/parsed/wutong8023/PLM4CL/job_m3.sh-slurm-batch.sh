#!/bin/bash
#SBATCH --job-name=prob_model_layer_bs_mean_std_fine__prob_model_layer_bs_mean_std_fine__prob_model_layer_bs_mean_std_coarse__prob_model_layer_bs_mean_std_coarse__prob_all_model_layer_bs_mean_std_coarse__prob_all_model_layer_bs_mean_std_coarse__prob_all_model_layer_bs_mean_std__prob_all_model_layer_bs_mean_std
#SBATCH --account=da33
#SBATCH --output=log/%j-prob_model_layer_bs_mean_std_fine__prob_model_layer_bs_mean_std_fine__prob_model_layer_bs_mean_std_coarse__prob_model_layer_bs_mean_std_coarse__prob_all_model_layer_bs_mean_std_coarse__prob_all_model_layer_bs_mean_std_coarse__prob_all_model_layer_bs_mean_std__prob_all_model_layer_bs_mean_std.out
#SBATCH --error=log/%j-prob_model_layer_bs_mean_std_fine__prob_model_layer_bs_mean_std_fine__prob_model_layer_bs_mean_std_coarse__prob_model_layer_bs_mean_std_coarse__prob_all_model_layer_bs_mean_std_coarse__prob_all_model_layer_bs_mean_std_coarse__prob_all_model_layer_bs_mean_std__prob_all_model_layer_bs_mean_std.err
#SBATCH --mail-user=wutong8023@163.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=64000
#SBATCH --time=7-00:00:00

module load anaconda/5.0.1-Python3.6-gcc5
source activate /home/twu/da33/tong/envs/pseudoCL/
module load cuda/11.0
python3 -m analyze.layer_probing --info prob_model_layer_bs_mean_std_fine --dataset seq-clinc150 --vis-type model_layer_mtd_final --vis_type model_layer_bs_mean_std_fine --prob_mtd derpp --prob_type proto --vis_by ptm --setting class  --pltf m
python3 -m analyze.layer_probing --info prob_model_layer_bs_mean_std_fine --dataset seq-clinc150 --vis-type model_layer_mtd_final --vis_type model_layer_bs_mean_std_fine --prob_mtd derpp --prob_type proto --vis_by ptm --setting task  --pltf m
python3 -m analyze.layer_probing --info prob_model_layer_bs_mean_std_coarse --dataset seq-clinc150 --vis-type model_layer_mtd_final --vis_type model_layer_bs_mean_std_coarse --prob_mtd derpp --prob_type proto --vis_by ptm --setting class  --pltf m
python3 -m analyze.layer_probing --info prob_model_layer_bs_mean_std_coarse --dataset seq-clinc150 --vis-type model_layer_mtd_final --vis_type model_layer_bs_mean_std_coarse --prob_mtd derpp --prob_type proto --vis_by ptm --setting task  --pltf m
python3 -m analyze.layer_probing --info prob_all_model_layer_bs_mean_std_coarse --dataset seq-clinc150 --vis-type model_layer_mtd_final --vis_type all_model_layer_bs_mean_std_coarse --prob_mtd derpp --prob_type proto --vis_by ptm --setting class  --pltf m
python3 -m analyze.layer_probing --info prob_all_model_layer_bs_mean_std_coarse --dataset seq-clinc150 --vis-type model_layer_mtd_final --vis_type all_model_layer_bs_mean_std_coarse --prob_mtd derpp --prob_type proto --vis_by ptm --setting task  --pltf m
python3 -m analyze.layer_probing --info prob_all_model_layer_bs_mean_std --dataset seq-clinc150 --vis-type model_layer_mtd_final --vis_type all_model_layer_bs_mean_std --prob_mtd derpp --prob_type proto --vis_by ptm --setting class  --pltf m
python3 -m analyze.layer_probing --info prob_all_model_layer_bs_mean_std --dataset seq-clinc150 --vis-type model_layer_mtd_final --vis_type all_model_layer_bs_mean_std --prob_mtd derpp --prob_type proto --vis_by ptm --setting task  --pltf m
