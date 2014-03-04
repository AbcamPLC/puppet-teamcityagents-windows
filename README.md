puppet-teamcity-agent for windows
==================================

This module installs a teamcity agent by copying the zip file installer contents to the local directory and creates a windows service. The teamcity agent does not appear in add/remove programs


The zip file installer requires that java be installed; the module will install java from a file share


Usage
============

1. Add the following to site.pp


   $posh_cmd = "C:\\Windows\\SysNative\\WindowsPowerShell\\v1.0\\powershell.exe -executionpolicy  remotesigned"
   $agenthome ="d:\\buildagent" 
   $javahome ="d:\\buildagent\\jre"
      
      if $osfamily == 'windows' {
         File { source_permissions => ignore } 
         # Puppet defaults to applying the ownership and permissions from the source files.(linux permission)
      
                               } 


	node 'myteamcityagent.mydomain.com' 
    	 {
      		 include 'teamcityagents'
     
     	 }

2. edit the buildagent.properties.erb to point the agent at your teamcity server.

3. edit $agenthome To change the teamcity install directory

4. edit $javahome To change the java install directory

5. change \\myfileserver\\Installers in java.pp you the location of your java media


Teamcity version 8.1, agent build 29879 - replace the modules files with the distribution zip if you require a different version



Requirement
=============   
    
puppet 3.4.2+ agent required (as file permission puppet changed in this version and there where enhancements to the package installs for windows)

TESTED ON WINDOWS R2



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

