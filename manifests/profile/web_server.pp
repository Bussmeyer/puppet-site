class site::profile::web_server {
  include ::nginx

  #cgi.fix_pathinfo=0
  #date.timezone = "Europe/Berlin"
  class { 'php::fpm':
    ensure => 'latest',
    package => 'php-fpm',
    service_name => 'php-fpm',
    inifile => '/etc/php-fpm.conf',
  }
}
