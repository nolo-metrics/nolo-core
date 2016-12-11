VERSION=0.1.0

BINS=\
	bin/nolo-gmetric \

METERS=\
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

FAKE_METERS=\
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

ALL=${BINS} ${TESTS} ${METERS} ${FAKE_METERS} ${FAKE_BINS}

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

pkg: pkg-deb
.PHONY: pkg

BUILDDIR=${PWD}/build
GOPATH=${BUILDDIR}
PREFIX=opt/nolo
build: ${METERS}
	rm -rf "${BUILDDIR}"
	mkdir -p "${BUILDDIR}"
	mkdir -p "${BUILDDIR}/${PREFIX}/sbin"
	mkdir -p "${BUILDDIR}/${PREFIX}/libexec/nolo/meters"
	mkdir -p "${BUILDDIR}/${PREFIX}/libexec/nolo/sinks"
	# nolo-json
	go get -u github.com/nolo-metrics/nolo-json
	mv "${BUILDDIR}/bin/nolo-json" "${BUILDDIR}/${PREFIX}/libexec/nolo/"
	# ganglia sink
	go get -u github.com/nolo-metrics/nolo-ganglia
	mv "${BUILDDIR}/bin/nolo-ganglia" "${BUILDDIR}/${PREFIX}/libexec/nolo/sinks/ganglia"
	# graphite sink
	# pip install git+https://github.com/nolo-metrics/nolo-graphite.git --target "${BUILDDIR}"
	# cleanup gopath stuff
	rm -rf "${BUILDDIR}/bin"
	rm -rf "${BUILDDIR}/src"
	rm -rf "${BUILDDIR}/pkg"
	# meters
	cp ${METERS} "${BUILDDIR}/${PREFIX}/libexec/nolo/meters/"

pkg-deb: build nolo_${VERSION}_amd64.deb
.PHONY: pkg-deb

nolo_${VERSION}_amd64.deb:
	fpm -s dir -t deb -n nolo -v ${VERSION} build

clean:
	rm -rf build
	rm -f *.deb
	rm -f tags

bootstrap:
	@(which fpm > /dev/null && echo "fpm found.") || echo "fpm not found! You'll need to install this on your own."
	@((which gnutar > /dev/null || which gtar > /dev/null) && echo "gnu tar found.") || echo "gnu tar not found! You'll need to install this on your own."
	@(which package_cloud > /dev/null && echo "package_cloud found.") || echo "package_cloud not found! You'll need to install this on your own."
.PHONY: bootstrap

publish: pkg
	package_cloud push josephholsten/nolo/ubuntu/trusty nolo_${VERSION}_amd64.deb
	package_cloud push josephholsten/nolo/ubuntu/xenial nolo_${VERSION}_amd64.deb
