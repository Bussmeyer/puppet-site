class site::profile::mysql_server (
  $databases = {}
) {
  include ::mysql::server

  create_resources("mysql::db", $databases)
}
