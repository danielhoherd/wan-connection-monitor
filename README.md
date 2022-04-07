# wan-connection-logger

Log WAN connection status, because Comcast sucks and we need a record of how much.

## Usage

```
git clone git@github.com:danielhoherd/wan-connection-monitor.git
cd wan-connection-monitor
make run
make logs
```

## View included help

```
$ make help
bounce          Rebuild, rm and run the Dockerfile
build           Build the Dockerfile found in PWD
debug           Build and debug the Dockerfile in pwd
help            Print Makefile help
install-hooks   Install git hooks
log             Create log dir
rm              Delete deployed container
run             Build and run the Dockerfile in pwd
show-logs       Show the last 30 minutes of log entries
stop            Delete deployed container
test            Test that the container functions
trim-logs       Trim 'alive' statements from logs so only failures remain
```

## Example logs output

```
2019-04-26 13:28:58-0700 73.70.9.223 18
2019-04-26 13:29:08-0700 73.70.9.223 19
2019-04-26 13:29:23-0700 FAILURE 1 (last_result: 73.70.9.223 19)
2019-04-26 13:29:38-0700 FAILURE 2
2019-04-26 13:29:53-0700 73.70.9.223 1 (last_result: FAILURE 2)
2019-04-26 13:30:03-0700 73.70.9.223 2
```

## TODO

- Rewrite completely using something other than bash OR find some existing tool to do this
- Separate out reporting from logging
