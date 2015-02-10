# Nolo

Nolo is a simple, flexible metric API to multiple metric collectors

Most of the time, all a metrics system really needs is an identifier and a value. So the simplest possible plugin should just do that:

    % ./app_plugin
    connections_open 216
    requests 153

Of course many collector systems support extra metadata, so it should be easy to include this as well:

    % ./app_plugin
    connections_open 216 time=1200928930 type=uint16 host=darkstar
    requests 153 release=2.24.2.4271 type=uint8 host=darkstar

Sink adapters are free to use these metadata pairs as they like. Some will ignore them entirely, others will only use the ones that are meaningful, and a some will store them all. Refer to the individual adapter for how your system works.

## Installation

Extract the repo into the directory of your choice:

    PREFIX=/opt/nolo
    git clone https://github.com/nolo-metrics/nolo-core $PREFIX

Soon, nolo should be available in standard system packages. Feel free to help out!

## What you get

-   `meters/*` - all the useful meter plugins you could desire

For files to be provided by an install package, see the `Manifest` file.

## Sink Adapters

To connect your meters to the metrics aggregation system of your choice, you'll need to set up a sink. Here's what's working and supported today:

-   [nolo-graphite][] - written using the python API
-   [nolo-librato][] - written using the ruby API
-   [nolo-ganglia][] - written using the go API

Of course, we'd love to support every system out there! Here's a list of ones that don't have adapters (but probably should):

-   [InfluxDB][]
-   [OpenTSDB][]
-   [Server Density][]
-   [Cacti][]
-   [Munin][]
-   [collectd][]
-   [Scout][]
-   [StatsD][]
-   [Reimann][]

## About the name

I ran `grep '^....$' < /usr/share/dict/words` and skimmed. Nolo reminded me of YOLO and is the first part of "nolo contendere", a plea of no contest. Which is how I feel when I have to choose between plugin formats.

## See also

-   [Graphite][]: whose plain text protocol is impossibly simple yet impressively flexible
-   [Nagios][]: whose plugin format is the de facto standard in alerting

## LICENSE

Nolo is Copyright (c) 2012 [Joseph Anthony Pasquale Holsten][] and distributed under the ISC license. See the `LICENSE` file for more info.

  [nolo-graphite]: https://github.com/nolo-metrics/nolo-graphite
  [nolo-librato]: https://github.com/nolo-metrics/nolo-librato
  [nolo-ganglia]: https://github.com/nolo-metrics/nolo-ganglia
  [InfluxDB]: http://influxdb.com/
  [OpenTSDB]: http://opentsdb.net/
  [Server Density]: https://www.serverdensity.com/
  [Cacti]: http://cacti.net/
  [Munin]: http://munin-monitoring.org/
  [collectd]: http://collectd.org/
  [Scout]: https://scoutapp.com/
  [StatsD]: https://github.com/etsy/statsd
  [Reimann]: http://riemann.io/
  [Graphite]: http://graphite.wikidot.com
  [Nagios]: http://www.nagios.org
  [Joseph Anthony Pasquale Holsten]: http://josephholsten.com
