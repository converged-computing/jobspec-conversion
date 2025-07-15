#!/bin/bash
#FLUX: --job-name=blank-leopard-8868
#FLUX: -t=600
#FLUX: --priority=16

module load StdEnv/2023 arrow/15.0.1 rust/1.76.0 python scipy-stack
source ../../test-priv/test-priv-env/bin/activate
python -m src.main --use_yml_config --path_yml_config experiments/WikiText-2/paper/target_whole/generator_generation/dp_generator/generator_generation.yaml
nvidia-smi
deactivate
