#!/bin/bash
#SBATCH --job-name=main_all
#SBATCH --output=log/%J-main_all.out
#SBATCH --error=log/%J-main_all.err
#SBATCH --mail-user=wutong8023@163.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:1
#SBATCH --mem=128000
#SBATCH --time=70-00:00:00

module load python3
source /home/tongwu/envs/pseudoCL/bin/activate
module load cuda-11.2.0-gcc-10.2.0-gsjevs3
python3 -m analyze.time_ft_bt_acc_analysis --info main_all  --vis_type all  --vis_by ptm --setting class  --pltf gp
