#!/bin/bash
#SBATCH --account=desi
#SBATCH --output=JOB_OUT_%x_%j.txt
#SBATCH --error=JOB_ERR_%x_%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=debug
#SBATCH --constraint=cpu

source /global/common/software/desi/desi_environment.sh master
source /global/common/software/desi/users/adematti/cosmodesi_environment.sh main
module swap pyrecon/main pyrecon/mpi
PYTHONPATH=$PYTHONPATH:$HOME/LSS/py 
cd $HOME/LSS
tracer='LRG'
survey='main'
srun  -n 128 python scripts/main/apply_blinding_main_fromfile_fcomp.py --type LRG --specified_w0 -.9 --specified_wa 0.2 --specified_fnl 20 --get_par_mode specified --survey main --baoblind y --mkclusdat y --mkclusran y --dorecon y --rsdblind y --fnlblind y --minr 1 --maxr 2  --verspec mocks/FirstGenMocks/AbacusSummit/Y1/mock1 --version '' --basedir_out $SCRATCH/newtest2
fi
