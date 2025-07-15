#!/bin/bash
#FLUX: --job-name=boopy-mango-1560
#FLUX: --priority=16

python src/fairness_train_timm.py --config_path configs_unified_lr/dpn107/config_dpn107_CosFace_SGD_0.1_cosine.yaml #twins_svt_large/config_twins_svt_large_ArcFace_AdamW.yaml
