class site::role::server (
) {
  include ::site::profile::base
  include ::site::profile::web_server
  include ::site::profile::mysql_server
}
