$vcap_services = json_decode(getenv("VCAP_SERVICES"), TRUE);
$vcap_mysql_config = $vcap_services["mysql-5.1"][0]["credentials"];

$databases['default']['default'] = array (
    'database' => $vcap_mysql_config['name'],
    'username' => $vcap_mysql_config['user'],
    'password' => $vcap_mysql_config['password'],
    'host'     => $vcap_mysql_config['hostname'],
    'port'     => $vcap_mysql_config['port'],
    'driver' => 'mysql',
    'prefix' => '',
);
