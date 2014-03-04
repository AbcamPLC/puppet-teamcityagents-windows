 class teamcityagents::java{

      package { 'Java 7 Update 51':
        ensure          =>'7.0.510' ,
        source          => "\\myfileserver\\Installers\\Java\\jre-7u51-windows-i586.exe",
        install_options => [ '/s','STATIC=1','JAVAUPDATE=0','AUTOUPDATECHECK=0',"INSTALLDIR=${::javahome}"],
        notify => Exec["winfirewalljava"],
      }

      exec { "winfirewalljava":
       command   => "${::posh_cmd} -Command \"netsh advfirewall firewall add rule name=Java dir=in action=allow program='\"${::javahome}\"\\bin\\java.exe' ENABLE=yes\"",
       refreshonly => true,
       require =>  Package ['Java 7 Update 51'],
      }    
}