define site::profile::drupal_web_server::site (
  $www_root,
  $web_name = $name,
  $port = '80',
  $version = 1,
) {
  # http://wiki.nginx.org/Drupal
  nginx::resource::vhost { "${web_name}":
    listen_port => $port,
    www_root => "${www_root}",
    try_files => [ '$uri @rewrite' ],
  }

  nginx::resource::location { "@rewrite":
    priority => 402,
    vhost           => "${web_name}",
    www_root        => "${www_root}",
    ensure          => present,
    rewrite_rules => [ '^ /index.php' ],
  }

  nginx::resource::location { "${web_root}_root":
    priority => 403,
    vhost           => "${web_name}",
    www_root        => "${www_root}",
    ensure          => present,
    location        => '~ \.php$',
    index_files     => [ 'index.php', 'index.html', 'index.htm' ],
    proxy           => undef,
    fastcgi         => "127.0.0.1:9000",
    fastcgi_script  => undef,
    location_cfg_append => {
      fastcgi_connect_timeout => '3m',
      fastcgi_read_timeout    => '3m',
      fastcgi_send_timeout    => '3m'
    }
  }

  package {"${web_name}":
    ensure => "${version}-0",
    require => Yumrepo[ 'Releases' ],
  }
}
