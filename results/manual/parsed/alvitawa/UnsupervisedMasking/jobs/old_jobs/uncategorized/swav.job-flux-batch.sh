#!/bin/bash
#FLUX: --job-name=TRAIN
#FLUX: -c=3
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

source load.sh
python3 main.py --multirun main.model=pret dl.epochs=100 main.dataset=multicrop_cifar10 dl.optimizer=sgd dl.lr=0.15 dl.momentum=0.9 dl.batch_size=64 dl.weight_decay=0.000001 model.pret.init_scores_mean=1.0 model.pret.shell_mode=replace model.pret.module=swav model.pret.backbone=train model.pret.head_type=identity swav.queue_length=3840 swav.epoch_queue_starts=15 swav.nmb_prototypes=50,100,3000 dl.scheduler=cosine dl.final_lr=0.00015 dl.warmup_epochs=0 dl.num_workers=12 dl.batch_accum=1 model.pret.source=timm model.pret.name=resnet18 swav.min_scale_crops=[0.5,0.3] swav.max_scale_crops=[1.0,0.75] swav.size_crops=[224,18] hydra/launcher=joblib hydra.launcher.n_jobs=3 dl.multiprocessing_context=fork
