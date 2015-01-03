class site::role::drupal_server (
  $drupal_sites = {}
) {
  validate_hash($drupal_sites)
  info("It's a single Drupal Server!")

  file { '/etc/motd':
    content => "\n
 ____                                     ___       ____                                             
/\  _`\                                  /\_ \     /\  _`\                                           
\ \ \/\ \  _ __   __  __  _____      __  \//\ \    \ \,\L\_\     __   _ __   __  __     __   _ __    
 \ \ \ \ \/\`'__\/\ \/\ \/\ '__`\  /'__`\  \ \ \    \/_\__ \   /'__`\/\`'__\/\ \/\ \  /'__`\/\`'__\  
  \ \ \_\ \ \ \/ \ \ \_\ \ \ \L\ \/\ \L\.\_ \_\ \_    /\ \L\ \/\  __/\ \ \/ \ \ \_/ |/\  __/\ \ \/   
   \ \____/\ \_\  \ \____/\ \ ,__/\ \__/.\_\/\____\   \ `\____\ \____\\ \_\  \ \___/ \ \____\\ \_\   
    \/___/  \/_/   \/___/  \ \ \/  \/__/\/_/\/____/    \/_____/\/____/ \/_/   \/__/   \/____/ \/_/   
                            \ \_\                                                                    
                             \/_/                                                                    
                                                                                                     \n"
  }

  include ::site::profile::base
  include ::site::profile::drupal_web_server
  include ::site::profile::mysql_server

  create_resources("site::profile::drupal_web_server::site", $drupal_sites)
}
