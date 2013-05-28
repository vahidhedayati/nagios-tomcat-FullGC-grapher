nagios-tomcat-FullGC-grapher
============================

This will graph out the amount of FullGC's Per hour within a tomcat application


On the remote host running tomcat, ensure gc logging is enabled


          JAVA_OPTS="$JAVA_OPTS -verbose:gc"
          JAVA_OPTS="$JAVA_OPTS -Xloggc:$CATALINA_HOME/logs/gc.log"
          JAVA_OPTS="$JAVA_OPTS -XX:+PrintGCDetails"
          JAVA_OPTS="$JAVA_OPTS -XX:+PrintGCDateStamps"
          
          
          
