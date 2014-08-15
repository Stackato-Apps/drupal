#!/bin/bash

file=`dirname $0`"/includes/bootstrap.inc"
line="$(sed -n '/is_https =/=' $file)"

# remove line that sets is_https
sed -i "$line"d $file

# get value of sso_enabled from VCAP_APPLICATION environment variable
# add line back that sets is_https with additional check to see if sso is enabled
sed -i "$line"i"\$vcap_app = json_decode(getenv('VCAP_APPLICATION'), true);" $file
sed -i "$((line+1))"i"\$sso_enabled = \$vcap_app['sso_enabled'];" $file
sed -i "$((line+2))"i"\$is_https = \$sso_enabled || (isset(\$_SERVER['HTTPS']) && strtolower(\$_SERVER['HTTPS']) == 'on');" $file
