#!/bin/bash
# starts archivesspace and always runs any outstanding db migrations

# run migrations
/opt/archivesspace/scripts/setup-database.sh

# uncomment to re-index
#rm /opt/archivesspace/data/indexer_state/*
#rm /opt/archivesspace/data/indexer_pui_state/*
#rm -rf /opt/archivesspace/data/solr_index/*
#rm -rf /opt/archivesspace/data/solr_backups/*
#rm -rf /opt/archivesspace/data/solr_home/*
#rm -rf /opt/archivesspace/data/tmp/*

#start archivesspace
/opt/archivesspace/archivesspace.sh