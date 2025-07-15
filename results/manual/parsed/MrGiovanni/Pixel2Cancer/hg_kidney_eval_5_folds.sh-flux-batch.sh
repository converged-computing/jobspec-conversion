#!/bin/bash
#FLUX: --job-name=pixel2cancer_kidney
#FLUX: --priority=16

module load mamba/latest
source activate pixel2cancer
dist=$((RANDOM % 99999 + 10000))
datapath=/data/jliang12/zzhou82/datasets/PublicAbdominalData/
if [ $1 == 'eval.synt.kidney.fold0.no_pretrain.unet' ]; then
    python -W ignore validation.py --model=unet --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_0.json --log_dir runs_kidney/synt.kidney.fold0.no_pretrain.unet --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold0.pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_0.json --log_dir runs_kidney/synt.kidney.fold0.pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold0.no_pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_0.json --log_dir runs_kidney/synt.kidney.fold0.no_pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold0.no_pretrain.swin_unetrv2_small' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=small --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_0.json --log_dir runs_kidney/synt.kidney.fold0.no_pretrain.swin_unetrv2_small --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold0.no_pretrain.swin_unetrv2_tiny' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=tiny --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_0.json --log_dir runs_kidney/synt.kidney.fold0.no_pretrain.swin_unetrv2_tiny --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold1.no_pretrain.unet' ]; then
    python -W ignore validation.py --model=unet --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_1.json --log_dir runs_kidney/synt.kidney.fold1.no_pretrain.unet --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold1.pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_1.json --log_dir runs_kidney/synt.kidney.fold1.pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold1.no_pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_1.json --log_dir runs_kidney/synt.kidney.fold1.no_pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold1.no_pretrain.swin_unetrv2_small' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=small --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_1.json --log_dir runs_kidney/synt.kidney.fold1.no_pretrain.swin_unetrv2_small --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold1.no_pretrain.swin_unetrv2_tiny' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=tiny --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_1.json --log_dir runs_kidney/synt.kidney.fold1.no_pretrain.swin_unetrv2_tiny --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold2.no_pretrain.unet' ]; then
    python -W ignore validation.py --model=unet --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_2.json --log_dir runs_kidney/synt.kidney.fold2.no_pretrain.unet --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold2.pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_2.json --log_dir runs_kidney/synt.kidney.fold2.pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold2.no_pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_2.json --log_dir runs_kidney/synt.kidney.fold2.no_pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold2.no_pretrain.swin_unetrv2_small' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=small --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_2.json --log_dir runs_kidney/synt.kidney.fold2.no_pretrain.swin_unetrv2_small --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold2.no_pretrain.swin_unetrv2_tiny' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=tiny --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_2.json --log_dir runs_kidney/synt.kidney.fold2.no_pretrain.swin_unetrv2_tiny --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold3.no_pretrain.unet' ]; then
    python -W ignore validation.py --model=unet --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_3.json --log_dir runs_kidney/synt.kidney.fold3.no_pretrain.unet --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold3.pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_3.json --log_dir runs_kidney/synt.kidney.fold3.pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold3.no_pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_3.json --log_dir runs_kidney/synt.kidney.fold3.no_pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold3.no_pretrain.swin_unetrv2_small' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=small --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_3.json --log_dir runs_kidney/synt.kidney.fold3.no_pretrain.swin_unetrv2_small --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold3.no_pretrain.swin_unetrv2_tiny' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=tiny --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_3.json --log_dir runs_kidney/synt.kidney.fold3.no_pretrain.swin_unetrv2_tiny --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold4.no_pretrain.unet' ]; then
    python -W ignore validation.py --model=unet --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_4.json --log_dir runs_kidney/synt.kidney.fold4.no_pretrain.unet --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold4.pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_4.json --log_dir runs_kidney/synt.kidney.fold4.pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold4.no_pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_4.json --log_dir runs_kidney/synt.kidney.fold4.no_pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold4.no_pretrain.swin_unetrv2_small' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=small --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_4.json --log_dir runs_kidney/synt.kidney.fold4.no_pretrain.swin_unetrv2_small --save_dir out/kidney
elif [ $1 == 'eval.synt.kidney.fold4.no_pretrain.swin_unetrv2_tiny' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=tiny --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_4.json --log_dir runs_kidney/synt.kidney.fold4.no_pretrain.swin_unetrv2_tiny --save_dir out/kidney   
fi
if [ $1 == 'eval.real.kidney.fold0.no_pretrain.unet' ]; then
    python -W ignore validation.py --model=unet --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_0.json --log_dir runs_kidney/real.kidney.fold0.no_pretrain.unet --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold0.pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_0.json --log_dir runs_kidney/real.kidney.fold0.pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold0.no_pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_0.json --log_dir runs_kidney/real.kidney.fold0.no_pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold0.no_pretrain.swin_unetrv2_small' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=small --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_0.json --log_dir runs_kidney/real.kidney.fold0.no_pretrain.swin_unetrv2_small --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold0.no_pretrain.swin_unetrv2_tiny' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=tiny --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_0.json --log_dir runs_kidney/real.kidney.fold0.no_pretrain.swin_unetrv2_tiny --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold1.no_pretrain.unet' ]; then
    python -W ignore validation.py --model=unet --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_1.json --log_dir runs_kidney/real.kidney.fold1.no_pretrain.unet --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold1.pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_1.json --log_dir runs_kidney/real.kidney.fold1.pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold1.no_pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_1.json --log_dir runs_kidney/real.kidney.fold1.no_pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold1.no_pretrain.swin_unetrv2_small' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=small --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_1.json --log_dir runs_kidney/real.kidney.fold1.no_pretrain.swin_unetrv2_small --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold1.no_pretrain.swin_unetrv2_tiny' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=tiny --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_1.json --log_dir runs_kidney/real.kidney.fold1.no_pretrain.swin_unetrv2_tiny --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold2.no_pretrain.unet' ]; then
    python -W ignore validation.py --model=unet --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_2.json --log_dir runs_kidney/real.kidney.fold2.no_pretrain.unet --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold2.pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_2.json --log_dir runs_kidney/real.kidney.fold2.pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold2.no_pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_2.json --log_dir runs_kidney/real.kidney.fold2.no_pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold2.no_pretrain.swin_unetrv2_small' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=small --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_2.json --log_dir runs_kidney/real.kidney.fold2.no_pretrain.swin_unetrv2_small --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold2.no_pretrain.swin_unetrv2_tiny' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=tiny --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_2.json --log_dir runs_kidney/real.kidney.fold2.no_pretrain.swin_unetrv2_tiny --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold3.no_pretrain.unet' ]; then
    python -W ignore validation.py --model=unet --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_3.json --log_dir runs_kidney/real.kidney.fold3.no_pretrain.unet --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold3.pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_3.json --log_dir runs_kidney/real.kidney.fold3.pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold3.no_pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_3.json --log_dir runs_kidney/real.kidney.fold3.no_pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold3.no_pretrain.swin_unetrv2_small' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=small --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_3.json --log_dir runs_kidney/real.kidney.fold3.no_pretrain.swin_unetrv2_small --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold3.no_pretrain.swin_unetrv2_tiny' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=tiny --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_3.json --log_dir runs_kidney/real.kidney.fold3.no_pretrain.swin_unetrv2_tiny --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold4.no_pretrain.unet' ]; then
    python -W ignore validation.py --model=unet --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_4.json --log_dir runs_kidney/real.kidney.fold4.no_pretrain.unet --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold4.pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_4.json --log_dir runs_kidney/real.kidney.fold4.pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold4.no_pretrain.swin_unetrv2_base' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=base --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_4.json --log_dir runs_kidney/real.kidney.fold4.no_pretrain.swin_unetrv2_base --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold4.no_pretrain.swin_unetrv2_small' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=small --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_4.json --log_dir runs_kidney/real.kidney.fold4.no_pretrain.swin_unetrv2_small --save_dir out/kidney
elif [ $1 == 'eval.real.kidney.fold4.no_pretrain.swin_unetrv2_tiny' ]; then
    python -W ignore validation.py --model=swin_unetrv2 --swin_type=tiny --val_overlap=0.75 --val_dir $datapath --json_dir datafolds/5_fold/kidney/kidney_tumor_4.json --log_dir runs_kidney/real.kidney.fold4.no_pretrain.swin_unetrv2_tiny --save_dir out/kidney   
fi
