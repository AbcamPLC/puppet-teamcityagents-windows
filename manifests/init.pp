
#NOTE installing from the zip installer doesn't not add TCagent into add/remove programs
class teamcityagents {
  
      
  include teamcityagents::java
  include teamcityagents::service
  Class['teamcityagents'] ->   Class ['teamcityagents::java']   -> Class ['teamcityagents::service']
   #apply the classes in this order

     
  
    file {  $::agenthome:
      ensure  => directory,
      recurse => true,
      source  => "puppet:///modules/teamcityagents/buildagent",
      force   => true,
      notify => Exec['TCserviceinstall'],
      #copys files from puppet module to the local folder created above
         }
   

  file { "${::agenthome}\\AddAccountToLogonAsService.ps1":
    ensure  => present,
    source  => "puppet:///modules/teamcityagents/AddAccountToLogonAsService.ps1",
    #copy powershell script to local server
        }
        
   file { "${::agenthome}\\SetADAccountasLocalAdministrator.ps1":
    ensure  => present,
    source  => "puppet:///modules/teamcityagents/SetADAccountasLocalAdministrator.ps1",
    notify => Exec["TCaccountpermission"],
    #copy powershell script to local server
        }     
   
  file { "${::agenthome}\\conf\\buildAgent.properties":
    ensure => present,
    replace => 'no',
    content => template('teamcityagents/buildAgent.properties.erb'),
    require => File["$::agenthome"],
    owner   => 'administrators',
    group   => 'users',
    mode    => 0640, 
    #copy conf\ buildAgent.properties and change servername (template with custom fact $servername)
        }
 
 
   exec { 'TCserviceinstall':
    command   => "${::posh_cmd} -command ${::agenthome}\\launcher\\bin\\TeamCityAgentService-windows-x86-32.exe -i '${::agenthome}\\launcher\\conf\\wrapper.conf'",
    refreshonly => true,
 #   notify => Exec["SetTClogonServiceRights"],
    require => File["${::agenthome}"],
      #install TC as a service
    
        }
        
 /*      
  exec { 'SetTClogonServiceRights':
    command   => "${::posh_cmd} ${::agenthome}\\AddAccountToLogonAsService.ps1 \"mydomain\\myteamcityserviceaccount\"",
    refreshonly => true,
    notify => Exec["TCserviceaccount"],
    require => File["${::agenthome}\\AddAccountToLogonAsService.ps1"],
    #sets logon as a serivce rights
        }
      
 
   exec { "TCserviceaccount":
      command   => "${::posh_cmd} -command sc.exe config TCBuildAgent obj= mydomain\\myteamcityserviceaccount  password= mypass type= own",
      refreshonly => true,
     #change the account the windows service runs under
        }
        
    exec { "TCaccountpermission":
      command   => "${::posh_cmd} ${::agenthome}\\SetADAccountasLocalAdministrator.ps1 -Computer localhost -Trustee \"mydomain\\myteamcityserviceaccount\"",
      refreshonly => true,
      require => File["${::agenthome}\\SetADAccountasLocalAdministrator.ps1"],
      #add user to local admins group
         
        }   
 
       */  
                         }
 
#TODO automate agent authorization on the TC server, API?




