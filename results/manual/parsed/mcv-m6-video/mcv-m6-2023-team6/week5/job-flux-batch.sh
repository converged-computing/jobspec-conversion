#!/bin/bash
#FLUX: --job-name=psycho-gato-3778
#FLUX: -n=10
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate m6
echo "Starting the YOLOv8 inference for detection"
python inference_yolov8.py
echo "Starting the MTSC for MAX_IOU_WITHOUT_OF"
python MTSC.py --OF 0
python pre_MTMC.py --OF 0
echo "Starting the MTMC for MAX_IOU_WITHOUT_OF"
python vehicle_mtmc/mtmc/run_mtmc.py --config AI_city/mtmc_s01_max_iou.yaml  
python vehicle_mtmc/mtmc/run_mtmc.py --config AI_city/mtmc_s03_max_iou.yaml 
python vehicle_mtmc/mtmc/run_mtmc.py --config AI_city/mtmc_s04_max_iou.yaml    
echo "Starting the MTSC for MAX_IOU_WITH_OF"
python MTSC.py --OF 1
python pre_MTMC.py --OF 1 
echo "Starting the MTMC for MAX_IOU_WITH_OF"
conda activate m6
python vehicle_mtmc/mtmc/run_mtmc.py --config AI_city/mtmc_s03_max_iou_OF.yaml
python vehicle_mtmc/mtmc/run_mtmc.py --config AI_city/mtmc_s01_max_iou_OF.yaml
python vehicle_mtmc/mtmc/run_mtmc.py --config AI_city/mtmc_s04_max_iou_OF.yaml 
echo "Starting the MTSC for DEEP_SORT"
echo "Starting mtmc/run_express_mtmc.py s01"
python vehicle_mtmc/mtmc/run_express_mtmc.py --config AI_city/end2end_DeepSort_s01.yaml
echo "Starting mtmc/run_express_mtmc.py s03"
python vehicle_mtmc/mtmc/run_express_mtmc.py --config AI_city/end2end_DeepSort_s03.yaml
echo "Starting mtmc/run_express_mtmc.py s04"
python vehicle_mtmc/mtmc/run_express_mtmc.py --config AI_city/end2end_DeepSort_s04.yaml
echo "Starting the MTSC for BYTE_TRACK"
echo "Starting mtmc/run_express_mtmc.py s01"
python vehicle_mtmc/mtmc/run_express_mtmc.py --config AI_city/end2end_ByTrack_s01.yaml 
echo "Starting mtmc/run_express_mtmc.py s03"
python vehicle_mtmc/mtmc/run_express_mtmc.py --config AI_city/end2end_ByTrack_s03.yaml 
echo "Starting mtmc/run_express_mtmc.py s04"
python vehicle_mtmc/mtmc/run_express_mtmc.py --config AI_city/end2end_ByTrack_s04.yaml  
