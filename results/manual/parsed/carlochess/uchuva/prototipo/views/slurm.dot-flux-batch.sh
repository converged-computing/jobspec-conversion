#!/bin/bash
#FLUX: --job-name={{=
#FLUX: --queue=debug
#FLUX: -t=3600
#FLUX: --urgency=16

{{? it.config.times && it.config.times > 1 }}#SBATCH --array 1-{{= it.config.times}}{{?}}
{{? it.nodo.dependencia && it.nodo.dependencia.length > 0 }}#SBATCH --dependency=afterok:{{= it.nodo.dependencia.join(":")}}{{?}}
{{? it.config.useDocker }}
docker run -it -v {{= it.dagdir}}/{{= it.nodo.directorio}}:{{= it.dagdir}}/{{= it.nodo.directorio}} --workdir {{= it.dagdir}}/{{= it.nodo.directorio}} {{= it.config.image }} {{= it.config.location && it.config.location.trim() }} {{= it.config.argumento.trim() }}
{{??}}
{{? it.config.module }}module load {{= it.config.module }}{{?}}
{{? it.config.wd }}cd {{= it.config.wd }}{{?}}
{{= it.config.location && it.config.location.trim() }} {{= it.config.argumento.trim() }}
{{?}}
