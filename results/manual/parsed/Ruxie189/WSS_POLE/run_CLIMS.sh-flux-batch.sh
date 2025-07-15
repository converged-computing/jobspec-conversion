#!/bin/bash
#FLUX: --job-name=red-citrus-8907
#FLUX: -c=16
#FLUX: -t=21600
#FLUX: --priority=16

source /home/ruxie/projects/def-josedolz/ruxie/dl/bin/activate
CUDA_VISIBLE_DEVICES=0 python run_sample.py --voc12_root /home/ruxie/projects/def-josedolz/ruxie/Data/VOCdevkit/VOC2012/ --hyper 10.0,25.0,1.0,0.0 --clims_num_epoches 15 --cam_eval_thres 0.15 --clims_network net.resnet50_clims --work_space /home/ruxie/scratch/ruxie/clims_og_25 --train_list voc12/train_aug.txt --train_clims_pass True --make_clims_pass True --eval_cam_pass True --log_name train_eval_abl --cam_weights_name /home/ruxie/projects/def-josedolz/ruxie/CLIP-WSL/cam-baseline-voc12/res50_cam.pth --cam_out_dir cam_mask --clims_weights_name res50_clims --clims_use_adapter False --json_file GPT_4_2 --cam_eval_thres 0.15
CUDA_VISIBLE_DEVICES=0 python run_sample.py --voc12_root /home/ruxie/projects/def-josedolz/ruxie/Data/VOCdevkit/VOC2012/ --cam_eval_thres 0.15 --work_space /home/ruxie/scratch/ruxie/clims_og_25 --cam_network net.resnet50_clims --cam_to_ir_label_pass True --train_irn_pass True --irn_num_epoches 3 --make_sem_seg_pass True --eval_sem_seg_pass True --irn_weights_name res50_irn.pth --ir_label_out_dir ir_label --sem_seg_out_dir sem_seg --ins_seg_out_dir ins_seg --log_name train_eval --cam_weights_name /home/ruxie/projects/def-josedolz/ruxie/CLIP-WSL/cam-baseline-voc12/res50_cam.pth --cam_out_dir cam_mask --clims_weights_name res50_clims --seg_list voc12/train.txt
deactivate
