#!/bin/bash

cd /var/www/panel/scripts

echo "Start: $(date '+%d/%m/%Y %H:%M:%S')"

psql -h $POSTGRESQL_DB_HOST -d $POSTGRESQL_DB_NAME -U $POSTGRESQL_DB_USERNAME -c 'delete from ur; delete from mp;'
ruby scan_UR.rb $1 $2 -79.85 15.92 -77.85 14.92 1.0
ruby scan_UR.rb $1 $2 -80.85 14.92 -79.85 13.92 1.0
ruby scan_UR.rb $1 $2 -81.85 13.92 -80.85 12.92 1.0
ruby scan_UR.rb $1 $2 -81.85 12.92 -80.85 11.92 1.0
ruby scan_UR.rb $1 $2 -72.85 12.92 -70.85 11.92 1.0
ruby scan_UR.rb $1 $2 -75.85 11.92 -70.85 10.92 1.0
ruby scan_UR.rb $1 $2 -75.85 10.92 -71.85 9.92 1.0
ruby scan_UR.rb $1 $2 -77.85 9.92 -71.85 8.92 1.0
ruby scan_UR.rb $1 $2 -78.85 8.92 -71.85 7.92 1.0
ruby scan_UR.rb $1 $2 -78.85 7.92 -69.85 6.92 1.0
ruby scan_UR.rb $1 $2 -77.85 6.92 -66.85 5.92 1.0
ruby scan_UR.rb $1 $2 -77.85 5.92 -66.85 4.92 1.0
ruby scan_UR.rb $1 $2 -81.85 4.92 -80.85 3.92 1.0
ruby scan_UR.rb $1 $2 -77.85 4.92 -66.85 3.92 1.0
ruby scan_UR.rb $1 $2 -78.85 3.92 -66.85 2.92 1.0
ruby scan_UR.rb $1 $2 -78.85 2.92 -66.85 1.92 1.0
ruby scan_UR.rb $1 $2 -79.85 1.92 -66.85 0.92 1.0
ruby scan_UR.rb $1 $2 -78.85 0.92 -68.85 -0.08 1.0
ruby scan_UR.rb $1 $2 -75.85 -0.08 -68.85 -1.08 1.0
ruby scan_UR.rb $1 $2 -74.85 -1.08 -68.85 -2.08 1.0
ruby scan_UR.rb $1 $2 -73.85 -2.08 -68.85 -3.08 1.0
ruby scan_UR.rb $1 $2 -70.85 -3.08 -68.85 -4.08 1.0
ruby scan_UR.rb $1 $2 -70.85 -4.08 -69.85 -5.08 1.0

psql -h $POSTGRESQL_DB_HOST -d $POSTGRESQL_DB_NAME -U $POSTGRESQL_DB_USERNAME -c 'update ur set city_id = (select id from cities where ST_Contains(geom, ur.position) limit 1) where city_id is null;'
psql -h $POSTGRESQL_DB_HOST -d $POSTGRESQL_DB_NAME -U $POSTGRESQL_DB_USERNAME -c 'update mp set city_id = (select id from cities where ST_Contains(geom, mp.position) limit 1) where city_id is null;'
psql -h $POSTGRESQL_DB_HOST -d $POSTGRESQL_DB_NAME -U $POSTGRESQL_DB_USERNAME -c 'update mp set weight = 0 where weight is null;'
psql -h $POSTGRESQL_DB_HOST -d $POSTGRESQL_DB_NAME -U $POSTGRESQL_DB_USERNAME -c 'update ur set comments = 0 where comments is null and resolved_on is not null;'
psql -h $POSTGRESQL_DB_HOST -d $POSTGRESQL_DB_NAME -U $POSTGRESQL_DB_USERNAME -c 'refresh materialized view vw_ur;'
psql -h $POSTGRESQL_DB_HOST -d $POSTGRESQL_DB_NAME -U $POSTGRESQL_DB_USERNAME -c 'refresh materialized view vw_mp;'
psql -h $POSTGRESQL_DB_HOST -d $POSTGRESQL_DB_NAME -U $POSTGRESQL_DB_USERNAME -c "update updates set updated_at = current_timestamp where object = 'ur';"
psql -h $POSTGRESQL_DB_HOST -d $POSTGRESQL_DB_NAME -U $POSTGRESQL_DB_USERNAME -c 'vacuum analyze;'

echo "End: $(date '+%d/%m/%Y %H:%M:%S')"
