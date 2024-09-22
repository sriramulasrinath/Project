Playbook Details
Playbook Name: Automate SQL Server Installation
Hosts: All (targets all hosts defined in the inventory)
Privilege Escalation: Yes (uses become: yes to execute tasks with elevated privileges)
Variables:
sql_package_path: Path to the SQL Server RPM package file.

Tasks
1) Check if SQL Server is already installed

Module: ansible.builtin.shell
Command: rpm -q mssql-server
Purpose: Queries the RPM package manager to check if the mssql-server package is installed.
Register Variable: sql_server_installed
Ignore Errors: Yes (to handle cases where the package is not installed)
Changed When: False (the task does not change system state)

2) Install SQL Server package if not already installed

Module: ansible.builtin.package
Name: {{ sql_package_path }}
State: Present
Purpose: Installs the SQL Server RPM package if it is not already installed, based on the result from the previous task.
Condition: Executes only if sql_server_installed.rc (return code) is not equal to 0 (indicating the package is not installed).

3) Ensure SQL Server service is started and enabled

Module: ansible.builtin.systemd
Name: mssql-server
Enabled: Yes
State: Started
Purpose: Ensures that the SQL Server service is running and enabled to start on boot.

4) Check if SQL Server configuration is already done

Module: ansible.builtin.stat
Path: /var/opt/mssql/data/master.mdf
Register Variable: sql_configured
Purpose: Checks if the SQL Server configuration file exists to determine if SQL Server has been configured.

5) Configure SQL Server if not already configured

Module: ansible.builtin.shell
Command: /opt/mssql/bin/mssql-conf setup accept-eula
Purpose: Runs the SQL Server setup command to accept the End User License Agreement (EULA) and complete the configuration if SQL Server has not been configured yet.
Condition: Executes only if the SQL Server configuration file (master.mdf) does not exist.

6) Test SQL Server connection

Module: ansible.builtin.shell
Command: sqlcmd -S localhost -U {{ username }} -P '{{ password }}' -Q "SELECT @@VERSION"
Register Variable: sql_test
Purpose: Tests the connection to SQL Server and retrieves the server version.
Changed When: False (the task does not change system state)

7) Display SQL Server version

Module: ansible.builtin.debug
Message: {{ sql_test.stdout }}
Purpose: Displays the SQL Server version retrieved from the previous task.