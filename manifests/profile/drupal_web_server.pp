class site::profile::drupal_web_server {
  include ::nginx

  #cgi.fix_pathinfo=0
  #date.timezone = "Europe/Berlin"
  class { 'php::fpm':
    ensure => 'latest',
    package => 'php-fpm',
    service_name => 'php-fpm',
    inifile => '/etc/php-fpm.conf',
  }

  class { 'php::extension::mysql':
    package => 'php-mysql',
  }
  class { 'php::extension::gd':
    package => 'php-gd',
  }
  php::extension { 'xml':
    ensure   => "latest",
    package  => "php-xml",
  }
  php::extension { 'mbstring':
    ensure   => "latest",
    package  => "php-mbstring",
  }

  class {'drush':
    version => '6.*',  # Version options include specific values like '6.2.0', latest stable as '6.*' or dev with 'dev-master'
    drush_cmd => '/usr/bin/drush', # Directory to place the drush executable
    composer_home => '/usr/local/share/composer', # Directory where composer will install drush
  }
}
