#!/usr/bin/env bash
#


NOW=$(date +"%Y%m%d.%H%M%S")

declare -A NAMED_VOLUMES=( \
	["instance"]="/usr/local/var/instance" \
	["data"]="/usr/local/var/instance/data" \
	#["es_data"]="/var/lib/postgresql/data"\
)

#declare -A NAMED_VOLUMES=( ["data"]="/usr/local/var/instance/data" )

DEST_HOST_PATH="/tmp"

############################################################################################

for path in "${!NAMED_VOLUMES[@]}"; 
do
	echo -e "\n BACKUP(ing) $path - ${NAMED_VOLUMES[$path]} TO $DEST_HOST_PATH \n";
	docker run --rm --volumes-from zenodo_static_1 \
		-w ${NAMED_VOLUMES[$path]} \
		-v $DEST_HOST_PATH:/backup ubuntu \
		tar cPzf /backup/backup-$path-$NOW.tar.gz . #${NAMED_VOLUMES[$path]}
done

############################################################################################

echo -e "\n BACKUP(ing) DB_DATA TO $DEST_HOST_PATH \n";
docker run --rm --volumes-from zenodo_db_1 \
	-v $DEST_HOST_PATH:/backup ubuntu \
	tar cPzf /backup/backup-db_data-$NOW.tar.gz /var/lib/postgresql/data


############################################################################################

declare -A METHODS=( ["plain"]="a" ["custom"]="c" ["tar"]="t")

for method in "${!METHODS[@]}";
do
	echo -e "\n DB-Backup - $method"
	docker exec zenodo_db_1 pg_dump -U zenodo --encoding utf8 \
		-F ${METHODS[$method]} zenodo > ${DEST_HOST_PATH}/db-$method-$NOW.dump
done