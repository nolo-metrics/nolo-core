PGNAME=`basename $0`

#!/bin/sh
# mktmp - portable prefixing mktemp using TMPDIR

mktmp() {
	TMPDIR=${TMPDIR:-/tmp}
	PREFIX=$1
	mktemp ${TMPDIR}/${PREFIX}.XXXXXXXXXX || exit 1
}

source_stubs() {
  kind=$1
  if [ -z $kind ]
  then
    PATH="test/fake/bin:$PATH"
  else
    PATH="test/fake/${kind}-bin:$PATH"
  fi
}

assert_eq() {
	actual=$1
	expected=$2
	if ! [ "${actual}" = "${expected}" ]
	then
		echo "${PGNAME}: ${command} failed!"
		if which wdiff > /dev/null
		then
			# minimize and colorize output
			ACTUAL=`mktmp actual`
			EXPECTED=`mktmp expected`
			echo "${actual}" > $ACTUAL
			echo "${expected}" > $EXPECTED
			diff -u $ACTUAL $EXPECTED |
			wdiff \
				--diff-input \
				--avoid-wraps \
				--start-delete $'\033[30;41m' \
				--end-delete $'\033[0m' \
				--start-insert $'\033[30;42m' \
				--end-insert $'\033[0m'
			rm -f $ACTUAL $EXPECTED
		elif which diff > /dev/null
		then
			# minimize output
			ACTUAL=`mktmp actual`
			EXPECTED=`mktmp expected`
			echo "${actual}" > $ACTUAL
			echo "${expected}" > $EXPECTED
			diff -u $ACTUAL $EXPECTED
			rm -f $ACTUAL $EXPECTED
		else
			echo "Got:"
			echo "${actual}"
			echo
			echo "but expected:"
			echo "${expected}"
		fi
		exit -1
	fi
}
