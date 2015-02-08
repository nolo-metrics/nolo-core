BINS=\
	bin/nolo-gmetric \

PLUGINS=\
	meters/cpu-darwin \
	meters/cpu-freebsd \
	meters/cpu-linux \
	meters/cpu-sunos \
	meters/nginx \
	meters/passenger \
	meters/proc \
	meters/redis \

TESTS=\
	test/gmetric/check-exec \
	test/gmetric/empty-params \
	test/gmetric/multiple \
	test/gmetric/single \
	test/meters/cpu-freebsd \
	test/meters/cpu-linux \
	test/meters/cpu-sunos \
	test/meters/nginx \
	test/meters/passenger \
	test/meters/proc-darwin \
	test/meters/proc-freebsd \
	test/meters/proc-linux \
	test/meters/proc-sunos \
	test/meters/redis \

FAKE_PLUGINS=\
	test/fake/meters/failing-return \
	test/fake/meters/inline-metadata \
	test/fake/meters/multiple \
	test/fake/meters/not-executable \
	test/fake/meters/shared-metadata \
	test/fake/meters/single \

FAKE_BINS=\
	test/fake/bin/passenger-memory-stats \
	test/fake/bin/passenger-status \
	test/fake/darwin-bin/ps \
	test/fake/darwin-bin/uptime \
	test/fake/freebsd-bin/ps \
	test/fake/freebsd-bin/uptime \
	test/fake/linux-bin/ps \
	test/fake/linux-bin/uptime \
	test/fake/sunos-bin/ps \
	test/fake/sunos-bin/uptime \

ALL=${BINS} ${TESTS} ${PLUGINS} ${FAKE_PLUGINS} ${FAKE_BINS}

test: ${ALL}
	test/gmetric/check-exec
	test/gmetric/empty-params
	test/gmetric/multiple
	test/gmetric/single
	test/meters/cpu-freebsd
	test/meters/cpu-linux
	test/meters/cpu-sunos
	test/meters/nginx
	test/meters/passenger
	test/meters/proc-darwin
	test/meters/proc-freebsd
	test/meters/proc-linux
	test/meters/proc-sunos
	test/meters/redis
.PHONY: test

tags: ${ALL}
	ctags -R .

clean:
	rm tags
