puppet-teacmcity
=====================

This module installs a teamcity agent by copying the zip file installer contents to the local directory and creates a windows service. The teamcity agent does not appear in add remove programs


The zip file installer requires that java be installed, the java module is called/included



Usage
============

Add the following to site.pp


   $posh_cmd = "C:\\Windows\\SysNative\\WindowsPowerShell\\v1.0\\powershell.exe -executionpolicy  remotesigned"
      $agenthome ="d:\\buildagent" 
      $javahome ="d:\\buildagent\\jre"
      
      if $osfamily == 'windows' {
         File { source_permissions => ignore } 
         # Puppet defaults to applying the ownership and permissions from the source files.(linux permission)
      
                               } 


node 'myteamcityagent.mydomain.com' {
       include 'teamcityagents'
  
   
}


Requirement
=============   
    
puppet 3.4.2+ agent required (as file permission puppet changed in this version and there where enhancements to the package installs for windows)

TESTED ON WINDOWS R2



Custom Teamcity server attributes
==================================

To point the agent at your teamcity server edit the buildagent.properties.erb

To change the agent directory that teamcity installs to edit site.pp variable $agenthome
To change the directory that java installs to edit site.pp variable $javahome


Teamcity version 8.1, agent build 29879 - replace the modules files with the distribution zip to change the version


Java installer
===================
change the source to your file server where the exe is located;
change \\myfileserver\\Installers in java.pp



Service Account Credentials
=============================
to run the teamcity agent as another user 
edit   exec { "TCserviceaccount" &  exec { 'SetTClogonServiceRights': &    exec { "TCaccountpermission":




Final Steps
=====================

You must manually authorize the teamcity build agent on the teamcity server



Powershell script acknowlegement
=====================================

http://gallery.technet.microsoft.com/scriptcenter/Grant-Log-on-as-a-service-11a50893

http://gallery.technet.microsoft.com/scriptcenter/Add-AD-UserGroup-to-Local-fe5e9239/view/Reviews

