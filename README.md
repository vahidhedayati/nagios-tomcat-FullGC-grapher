nagios-tomcat-FullGC-grapher
============================

This will graph out the amount of FullGC's Per hour within a tomcat application


On the remote host running tomcat, ensure gc logging is enabled


          JAVA_OPTS="$JAVA_OPTS -verbose:gc"
          JAVA_OPTS="$JAVA_OPTS -Xloggc:$CATALINA_HOME/logs/gc.log"
          JAVA_OPTS="$JAVA_OPTS -XX:+PrintGCDetails"
          JAVA_OPTS="$JAVA_OPTS -XX:+PrintGCDateStamps"
          
          
          

          # Add this to your nagios command.cfg
          define command{
                    command_name check_by_ssh
                    command_line $USER1$/check_by_ssh -H $HOSTADDRESS$ -p $ARG1$ -C "$ARG2$ $ARG3$ $ARG4$ $ARG5$ $ARG6$"
          }


          define service{
                    use                             your_group,srv-pnp
                    hostgroup_name                  {define host_group}
                    service_description             YOUR_APP Hourly GC Count
                    check_command                   check_by_ssh!22!/usr/local/bin/gc-count.sh!
                    ; custom config - not part of standard nagios
                    ; _contact_group                Call someone
          }


this should now start graphing GC counts on an hourly view for each time it runs 

Uses the gc-count.sh script provided which resides on remote host running tomcat - uses ssh to connect through and return the results
