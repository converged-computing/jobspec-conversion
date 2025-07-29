#!/bin/bash
#SBATCH --job-name=AcTh_Training
#SBATCH --mail-user=ie2651@partner.kit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=15000
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=1

module purge                                       # Unload all currently loaded modules.
module load devel/cuda/11.8
source ../ba_env/bin/activate   
configs=(
	"./src/conf/target_model_training/ATC3_CIFAR-100.yaml"
	#"./src/conf/target_model_training/Resnet_CIFAR-10.yaml"
	#"./src/conf/target_model_training/VGG_Mnist.yaml"
	#"./src/conf/target_model_training/VGG_CIFAR-10.yaml"
        #"./src/conf/basic_model_stealing/Random_Naive.yaml"
	#"./src/conf/basic_model_stealing/BALD_Naive.yaml"
        #"./src/conf/basic_model_stealing/CoreSet_Naive.yaml"
        #"./src/conf/basic_model_stealing/Badge_Naive.yaml"
)
for conf in "${configs[@]}"
do 
    echo "Running $conf with mode TR"
    python ./src/main.py -c $conf -m "TR"
done
deactivate
