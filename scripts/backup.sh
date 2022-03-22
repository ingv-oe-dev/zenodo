#!/usr/bin/env bash
#


NOW=$(date +"%m-%d-%Y-%T")

VOLUMES=("instance", "data", "python27_sitepkgs", "postgre_db")

declare -A NAMED_VOLUMES=( ["instance"]="/usr/local/var/instance" \
	["data"]="/usr/local/var/instance/data" \
	#["python27_sitepkgs"]="/usr/local/lib/python2.7/site-packages" \
	#["db_data"]="/var/lib/postgresql/data"\
)

#declare -A NAMED_VOLUMES=( ["data"]="/usr/local/var/instance/data" )

DEST_HOST_PATH="/tmp"

############################################################################################

for path in "${!NAMED_VOLUMES[@]}"; 
do
	echo -e "\n BACKUP(ing) $path - ${NAMED_VOLUMES[$path]} TO $DEST_HOST_PATH \n";
	docker run --rm --volumes-from zenodo_static_1 \
		-v $DEST_HOST_PATH:/backup ubuntu \
		tar cPzf /backup/backup-$path-$NOW.tar.gz ${NAMED_VOLUMES[$path]}
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
#if [ -d "$VIRTUAL_ENV/var/instance/data" ]; then
#    rm -Rf $VIRTUAL_ENV/var/instance/data
#fi

# Remove all data
#zenodo db destroy --yes-i-know
#zenodo db init
#zenodo queues purge
#zenodo index destroy --force --yes-i-know

# Initialize everything again
#script_path=$(dirname "$0")
#"$script_path/init.sh"
