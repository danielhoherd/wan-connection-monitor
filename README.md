# wan-connection-logger

Log WAN connection status, because Comcast sucks and we need a record of how much.

# Usage

```
$ git@github.com:danielhoherd/wan-connection-monitor.git
$ cd wan-connection-monitor
$ make run
$ make logs
```

# View included help

```
$ make help
bounce          Rebuild, rm and run the Dockerfile
build           Build the Dockerfile found in PWD
debug           Build and debug the Dockerfile in pwd
help            Print Makefile help
install-hooks   Install git hooks
logs            View the last 30 minutes of log entries
rm              Delete deployed container
run             Build and run the Dockerfile in pwd
stop            Delete deployed container
test            Test that the container functions
trim-logs       Trim 'alive' statements from logs so only failures remain
```
