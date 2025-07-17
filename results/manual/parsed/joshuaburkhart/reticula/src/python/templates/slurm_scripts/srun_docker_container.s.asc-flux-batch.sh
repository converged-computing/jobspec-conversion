#!/bin/bash
#FLUX: --job-name=bloated-toaster-2901
#FLUX: --urgency=16

srun mkdir -p ${scratchDataDir} ${scratchContDir}
srun cp ${lusRelDatPath} ${scratchDataDir}
srun cp ${lusRelDsnPath} ${scratchDataDir}
srun bzip2 -dc ${scratchDataDir}/${datFilNme} >${scratchDataDir}/decompressed.dat
srun bzip2 -dc ${scratchDataDir}/${dsnFilNme} >${scratchDataDir}/decompressed.dsn
srun cp ${lusRelImgPath} ${scratchContDir}/
srun ${exadocker} load --input ${scratchContDir}/${dockerImgFilNme}
srun ${exadocker} run --rm=true --volume "${scratchDataDir}:${dockerDataDir}" ${dockerNmeSpc}
srun ${exadocker} rmi "$(${exadocker} images | grep burk | tr -s ' ' | cut -d' ' -f3)"
srun tar cfjS ${lusRelDatDir}/node_data.tar.bz2 ${scratchDataDir}
srun rm -rf ${scratchHomeDir}
