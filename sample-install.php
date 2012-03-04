<?php

define('DRUPAL_ROOT', getcwd());
define('MAINTENANCE_MODE', 'install');

require_once DRUPAL_ROOT . '/includes/install.core.inc';

install_drupal(array(
  'parameters' => array(
    'profile' => 'standard',
    'locale' => 'en',
  ),
  'forms' => array(
    'install_configure_form' => array(
      'site_name' => 'Stackato sample site',
      'site_mail' => 'admin@example.com',
      'account' => array(
        'name' => 'admin',
        'mail' => 'admin@example.com',
        'pass' => array(
          'pass1' => 'passwd',
          'pass2' => 'passwd',
        ),
      ),
      'update_status_module' => array(1 => TRUE),
      'clean_url' => TRUE,
    ),
  ),
));
