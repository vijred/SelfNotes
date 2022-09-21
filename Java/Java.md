Java information
================

* what is JDK / JRE / JVM
    - Good Reference: https://www.youtube.com/watch?v=w2jlkcdvBSg 
* Java cmdline install on windows options 
    - Ref: https://web.mit.edu/java_v1.5.0_22/distrib/share/docs/guide/deployment/deployment-guide/silent.html
    - Example to chagne install directory: `C:\oracle\12212_jagent\Java_8\jdk-8u181-windows-x64.exe  /s  INSTALL_SILENT=1 REBOOT=0 INSTALLDIR=C:\oracle\Java\jdk1.8.0_181 /L c:\temp\jre-8u45-windows-x64.log`
* Good example to address issues running java from powershell 
    -   https://stackoverflow.com/questions/4685184/powershell-run-java-process-problem
* Example to set variables
    -   
        cd c:\
        set-item -path Env:CLASSPATH -value C:\Test 
        "CLASSPATH = $Env:CLASSPATH" 
        java.exe -classpath $Env:CLASSPATH HelloWorldApp

* Potential challenges automating Java program installation 
    1.  Most of the Java installations have options to use response file to pass all options from a text file, start consuming response file 
    2.  Second opiton is to pass the parameters from command prompt programatically , one of the samples is documented at https://stackoverflow.com/questions/7800368/equivalent-to-bash-expect-in-powershell/69499906#69499906

