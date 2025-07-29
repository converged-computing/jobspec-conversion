#!/bin/bash
#FLUX: --job-name=ASCAD_VAR_ATTACK
#FLUX: --queue=icis
#FLUX: -t=172800
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/:$CUDNN_PATH/lib'
export PYTHONPATH='${HOME}/src/:$PYTHONPATH'

BASE_DIR=/scratch/${USER}
CONDA_ENV=tf-cuda # Conda environment file path: /home/user/conda/env_name.yml
umask 027 # Make sure folders and files are created with sensible permissions
unset XDG_RUNTIME_DIR
source miniconda.sh
CUDNN_PATH="$(dirname "$(python -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)")")"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/:$CUDNN_PATH/lib
export PYTHONPATH="${HOME}/src/:$PYTHONPATH"
cd "${HOME}/src/SCA_FLR" || exit 1
echo "TASK_ID = $SLURM_ARRAY_TASK_ID"
case $SLURM_ARRAY_TASK_ID in
    1)
      # Finished
        python perform_attack.py ASCAD_variable normal mlp cer ID --attack
            ;;
    2)
        python perform_attack.py ASCAD_variable normal mlp cce ID --attack
    ;;
    3)
      # Finished
        python perform_attack.py ASCAD_variable desync50 mlp cer ID --attack
            ;;
    4)
        python perform_attack.py ASCAD_variable desync50 mlp cce ID --attack
    ;;
    5)
      # Finished
        python perform_attack.py ASCAD_variable desync100 mlp cer ID --attack
            ;;
    6)
        python perform_attack.py ASCAD_variable desync100 mlp cce ID --attack
    ;;
    7)
      # Finished
        python perform_attack.py ASCAD_variable normal cnn cer ID --attack
            ;;
    8)
        python perform_attack.py ASCAD_variable normal cnn cce ID --attack
    ;;
    9)
      # Finished
        python perform_attack.py ASCAD_variable desync50 cnn cer ID --attack
            ;;
    10)
        python perform_attack.py ASCAD_variable desync50 cnn cce ID --attack
    ;;
    11)
      # Finished
        python perform_attack.py ASCAD_variable desync100 cnn cer ID --attack
            ;;
    12)
        python perform_attack.py ASCAD_variable desync100 cnn cce ID --attack
    ;;
    13)
      # Error
        python perform_attack.py ASCAD_variable normal mlp cer HW --attack
            ;;
    14)
        python perform_attack.py ASCAD_variable normal mlp cce HW --attack
    ;;
    15)
        python perform_attack.py ASCAD_variable desync50 mlp cer HW --attack
            ;;
    16)
        python perform_attack.py ASCAD_variable desync50 mlp cce HW --attack
    ;;
    17)
        python perform_attack.py ASCAD_variable desync100 mlp cer HW --attack
            ;;
    18)
        python perform_attack.py ASCAD_variable desync100 mlp cce HW --attack
    ;;
    19)
      # Error
        python perform_attack.py ASCAD_variable normal cnn cer HW --attack
            ;;
    20)
        python perform_attack.py ASCAD_variable normal cnn cce HW --attack
    ;;
    21)
        python perform_attack.py ASCAD_variable desync50 cnn cer HW --attack
            ;;
    22)
        python perform_attack.py ASCAD_variable desync50 cnn cce HW --attack
    ;;
    23)
        python perform_attack.py ASCAD_variable desync100 cnn cer HW --attack
            ;;
    24)
        python perform_attack.py ASCAD_variable desync100 cnn cce HW --attack
    ;;
    *)
        echo -n "Unknown TASK_ID"
    ;;
esac
