#!/bin/bash
#FLUX: --job-name=carnivorous-rabbit-9040
#FLUX: -c=24
#FLUX: -t=172800
#FLUX: --priority=16

TARGET="0.25"
BEHAVIOR="0.3"
RUNTIMES="240"
STEPS="1000000"
ALPHA="0.05"
while [ "$1" != "" ]; do
    case $1 in
        -a | --alpha )          
                                shift
                                ALPHA=$1
                                ;;
        -e | --steps )       
                                shift
                                STEPS=$1
                                ;;
        -r | --runtimes )       
                                shift
                                RUNTIMES=$1
                                ;;
        --behavior )            
                                shift
                                BEHAVIOR=$1
                                ;;
        --target )              
                                shift
                                TARGET=$1
                                ;;                   
    esac
    shift
done
echo "alpha: $ALPHA"
echo "target: $TARGET, behavior: $BEHAVIOR"
echo "runtimes: $RUNTIMES, steps: $STEPS"
sleep 1
module load python/3.7 scipy-stack
source ~/ENV/bin/activate
python predict_ringworld.py --alpha $ALPHA --kappa 0 --steps $STEPS --runtimes $RUNTIMES --behavior $BEHAVIOR --target $TARGET --evaluate_MTA 0
python predict_ringworld.py --alpha $ALPHA --kappa 1e-7 --steps $STEPS --runtimes $RUNTIMES --behavior $BEHAVIOR --target $TARGET --evaluate_others 0
python predict_ringworld.py --alpha $ALPHA --kappa 1e-6 --steps $STEPS --runtimes $RUNTIMES --behavior $BEHAVIOR --target $TARGET --evaluate_others 0
python predict_ringworld.py --alpha $ALPHA --kappa 1e-5 --steps $STEPS --runtimes $RUNTIMES --behavior $BEHAVIOR --target $TARGET --evaluate_others 0
python predict_ringworld.py --alpha $ALPHA --kappa 1e-4 --steps $STEPS --runtimes $RUNTIMES --behavior $BEHAVIOR --target $TARGET --evaluate_others 0
python predict_ringworld.py --alpha $ALPHA --kappa 1e-3 --steps $STEPS --runtimes $RUNTIMES --behavior $BEHAVIOR --target $TARGET --evaluate_others 0
python predict_ringworld.py --alpha $ALPHA --kappa 1e-2 --steps $STEPS --runtimes $RUNTIMES --behavior $BEHAVIOR --target $TARGET --evaluate_others 0
python predict_ringworld.py --alpha $ALPHA --kappa 1e-1 --steps $STEPS --runtimes $RUNTIMES --behavior $BEHAVIOR --target $TARGET --evaluate_others 0
