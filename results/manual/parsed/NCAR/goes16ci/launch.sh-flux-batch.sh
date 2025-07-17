#!/bin/bash
#FLUX: --job-name=goes_hyper
#FLUX: -n=8
#FLUX: -t=86400
#FLUX: --urgency=16

module load ncarenv/1.3 gnu/8.3.0 openmpi/3.1.4 python/3.7.5 cuda/10.1
ncar_pylib /glade/work/schreck/py37
python /glade/work/schreck/py37/lib/python3.7/site-packages/aimlutils/hyper_opt/run.py hyperparameter.yml benchmark_config_default-Gunther.yml
