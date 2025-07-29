#!/bin/bash
#SBATCH --job-name=goes_hyper
#SBATCH --account=NAML0001
#SBATCH --output=goes_hyper.out
#SBATCH --error=goes_hyper.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem-per-cpu=768G
#SBATCH --time=1-00:00:00

module load ncarenv/1.3 gnu/8.3.0 openmpi/3.1.4 python/3.7.5 cuda/10.1
ncar_pylib /glade/work/schreck/py37
python /glade/work/schreck/py37/lib/python3.7/site-packages/aimlutils/hyper_opt/run.py hyperparameter.yml benchmark_config_default-Gunther.yml
