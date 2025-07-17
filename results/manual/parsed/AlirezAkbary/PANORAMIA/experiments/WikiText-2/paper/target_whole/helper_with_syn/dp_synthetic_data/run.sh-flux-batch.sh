#!/bin/bash
#FLUX: --job-name=misunderstood-cinnamonbun-4700
#FLUX: -t=300
#FLUX: --urgency=16

module load StdEnv/2023 arrow/15.0.1 rust/1.76.0 python scipy-stack
source ../../test-priv/test-priv-env/bin/activate
python -m src.main --use_yml_config --path_yml_config experiments/WikiText-2/paper/target_whole/helper_with_syn/dp_synthetic_data/helper_with_syn.yaml
nvidia-smi
deactivate
