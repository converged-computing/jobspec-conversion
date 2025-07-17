#!/bin/bash
#FLUX: --job-name=numpyro_sampler
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --urgency=16

source /users/afengler/.bashrc
module load cudnn/8.1.0
module load cuda/11.1.1
module load gcc/10.2
conda deactivate
conda deactivate
conda activate pymc-gpu
model=ddm
modeltype=singlesubject
nwarmup=100
nmcmc=100
idrange=10
echo "arguments passed to sbatch_network_training.sh $#"
nvidia-smi
while [ ! $# -eq 0 ]
    do
        case "$1" in
            --model | -m)
                echo "passing config file $2"
                model=$2
                ;;
            --modeltype | -t)
                echo "passing output_folder $2"
                modeltype=$2
                ;;
            --nwarmup | -w)
                echo "passing number of networks $2"
                nwarump=$2
                ;;
            --nmcmc | -m)
                echo "passing number of networks $2"
                nmcmc=$2
                ;;
            --idrange | -i)
                echo "passing deep learning backend specification: $2"
                idrange=$2
        esac
        shift 2
    done
echo "Output folder is: $output_folder"
python -u run_inference_numpyro.py --model $model \
                                   --modeltype $modeltype \
                                   --nwarmup $nwarmup \
                                   --nmcmc $nmcmc \
                                   --idmin $((SLURM_ARRAY_TASK_ID*idrange)) \
                                   --idmax $((SLURM_ARRAY_TASK_ID*idrange + idrange))
