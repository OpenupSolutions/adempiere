#!/bin/sh

#	This script rebuilds Adempiere 
#	Ported from Windows script Marek Mosiewicz<marek.mosiewicz@jotel.com.pl>
#	If you have difficulties, compare it with the Windows version.
#
#	$Header: /cvsroot/adempiere/utils_dev/myDevEnvTemplate.sh,v 1.6 2003/04/27 12:34:16 marekmosiewicz Exp $

#check java home
if [ $JAVA_HOME ]; then
  export PATH=$JAVA_HOME/bin:$PATH	
else
  echo JAVA_HOME is not set.
  echo You may not be able to build Adempiere
  echo Set JAVA_HOME to the directory of your local JDK.
  exit
fi

# check jdk
if  [ ! -f $JAVA_HOME/lib/tools.jar ] ; then
   echo "** Need full Java SDK **"
   exit
fi

#classpath
export JAVA_CLASSPATH=$CLASSPATH:../tools/lib/ant/org.apache.ant_1.10.8.v20200515-1239/lib/ant-launcher.jar:../tools/lib/commons-net.jar:$JAVA_HOME/lib/tools.jar
export JAVA_OPTS="-Xms128m -Xmx512m"
export ANT_HOME="../tools/lib/ant/org.apache.ant_1.10.8.v20200515-1239"

echo Cleanup ...
$JAVA_HOME/bin/java $JAVA_OPTS -classpath $JAVA_CLASSPATH -Dant.home=$ANT_HOME org.apache.tools.ant.launch.Launcher clean

echo Building ...
$JAVA_HOME/bin/java $JAVA_OPTS -classpath $JAVA_CLASSPATH -Dant.home=$ANT_HOME org.apache.tools.ant.launch.Launcher complete

echo Done ...

exit 0

