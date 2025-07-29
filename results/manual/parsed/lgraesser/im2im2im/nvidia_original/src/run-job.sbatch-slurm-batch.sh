#!/bin/bash
#SBATCH --job-name=clf
#SBATCH --mail-user=ag4508@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=100GB
#SBATCH --time=2-02:00:00

module load python/intel/2.7.12
module load pytorch/0.2.0_1
module load protobuf/intel/3.1.0
module load tensorboard_logger/0.0.3
module load torchvision/0.1.8
module load opencv/intel/3.2
python cocogan_train_fourway.py --config ../exps/unit/anant_smiling_blondbrunette_bigK_warmstart.yaml --log /scratch/ag4508/unit/log/ --warm_start 1 --gen_ab /scratch/ag4508/unit/exps/blondbrunette_smiling_bigK/blondbrunette_smiling_bigK_gen_00200000.pkl --dis_ab  /scratch/ag4508/unit/exps/blondbrunette_smiling_bigK/blondbrunette_smiling_bigK_dis_00200000.pkl --gen_cd /scratch/ag4508/unit/exps/smiling_bigK/smiling_bigK_gen_00200000.pkl --dis_cd /scratch/ag4508/unit/exps/smiling_bigK/smiling_bigK_dis_00200000.pkl --resume 1 
