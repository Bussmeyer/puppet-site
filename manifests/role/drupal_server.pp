class site::role::drupal_server (
  $drupal_sites = {}
) {
  validate_hash($drupal_sites)
  info("It's a single Drupal Server!")

  file { '/etc/motd':
    content => "\n
 ______      ____                       ___                             __                           
/\  _  \    /\  _`\   __               /\_ \                           /\ \                          
\ \ \L\ \   \ \ \L\ \/\_\   __  _    __\//\ \    _____      __     _ __\ \ \/'\                      
 \ \  __ \   \ \ ,__/\/\ \ /\ \/'\ /'__`\\ \ \  /\ '__`\  /'__`\  /\`'__\ \ , <                      
  \ \ \/\ \   \ \ \/  \ \ \\/>  <//\  __/ \_\ \_\ \ \L\ \/\ \L\.\_\ \ \/ \ \ \\`\                    
   \ \_\ \_\   \ \_\   \ \_\/\_/\_\ \____\/\____\\ \ ,__/\ \__/.\_\\ \_\  \ \_\ \_\                  
    \/_/\/_/    \/_/    \/_/\//\/_/\/____/\/____/ \ \ \/  \/__/\/_/ \/_/   \/_/\/_/                  
                                                   \ \_\                                             
                                                    \/_/                                             
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

  yumrepo {'Releases':
    descr    => 'Pixelpark Releases - x86_64',
    baseurl  => 'http://pp-dev-build-server:8081/nexus/content/repositories/releases',
    enabled  => 1,
    gpgcheck => 0,
    metadata_expire => 0m,
  }

  users { builder: }

  create_resources("site::profile::drupal_web_server::site", $drupal_sites)
}