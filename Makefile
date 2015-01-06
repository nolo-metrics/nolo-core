BINS=\
  bin/nolo-gmetric \

PLUGINS=\
  plugins/cpu-darwin \
  plugins/cpu-freebsd \
  plugins/cpu-linux \
  plugins/cpu-sunos \
  plugins/nginx \
  plugins/passenger \
  plugins/proc \
  plugins/redis \

TESTS=\
  test/gmetric/check-exec \
  test/gmetric/empty-params \
  test/gmetric/multiple \
  test/gmetric/single \
  test/plugins/passenger \
  test/plugins/proc \
  test/plugins/proc-darwin \
  test/plugins/proc-linux \
  test/plugins/proc-sunos \

FAKE_PLUGINS=\
  test/fake/plugins/failing-return \
  test/fake/plugins/inline-metadata \
  test/fake/plugins/multiple \
  test/fake/plugins/not-executable \
  test/fake/plugins/shared-metadata \
  test/fake/plugins/single \

FAKE_BINS=\
  test/fake/bin/passenger-memory-stats \
  test/fake/bin/passenger-status \
  test/fake/bin/ps \
  test/fake/bin/uptime \
  test/fake/darwin-bin/ps \
  test/fake/darwin-bin/uptime \
  test/fake/linux-bin/ps \
  test/fake/linux-bin/uptime \
  test/fake/sunos-bin/ps \
  test/fake/sunos-bin/uptime \

ALL=$(BINS) $(TESTS) $(PLUGINS) $(FAKE_PLUGINS) $(FAKE_BINS)

test: $(ALL)
	test/gmetric/check-exec
	test/gmetric/empty-params
	test/gmetric/multiple
	test/gmetric/single
	test/plugins/passenger
	test/plugins/proc
	test/plugins/proc-darwin
	test/plugins/proc-linux
	test/plugins/proc-sunos

tags: $(ALL)
	ctags -R .

clean:
	rm tags
