 class teamcityagents::service{

  
#net start TCBuildAgent or Run $agenthome/bin/service.start.bat 
service { 'TCBuildAgent':
      ensure => 'running',
      enable => true,
      hasstatus => false,
    }

}