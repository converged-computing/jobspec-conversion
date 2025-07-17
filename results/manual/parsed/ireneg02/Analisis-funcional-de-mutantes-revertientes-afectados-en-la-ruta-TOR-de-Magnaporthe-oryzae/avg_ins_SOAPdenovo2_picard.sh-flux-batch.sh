#!/bin/bash
#FLUX: --job-name=avg_ins_picard
#FLUX: --queue=fast
#FLUX: -t=600
#FLUX: --urgency=16

module use /beegfs/easybuild/CentOS/7.6.1810/Skylake/modules/all
module use /beegfs/easybuild/common/modules/all
module load picard/2.26.10-Java-15
module load R/4.2.0-foss-2021b
cd /home/ireneg/DATOS_DNA-SEQ/procesamiento/ #Nos desplazamos a la carpeta con las carpetas de las muestras
for folder in $(ls -d C*/); do #Recorremos las carpetas de las muestras
        cd $folder #Entramos en la carpeta
        file="${folder:0:18}" #Obtenemos el nombre de la muestra
        java -jar $EBROOTPICARD/picard.jar CollectInsertSizeMetrics -I BWA/bwa_map_${file}_merge_PE_SE.sam -O BWA/output_metrics_bwa_map_${file}_merge_PE_SE.sam.txt -H BWA/insert_size_histogram_bwa_map_${file}_merge_PE_SE.sam.pdf -M 0.5 #Obtenemos el tamaño de inserción usando Picard
        cd .. #Salimos de la carpeta de la muestra
done
