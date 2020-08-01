#! /bin/sh
#
# entrypoint.sh
# Copyright (C) 2020 Andres J. Diaz <ajdiaz@ajdiaz.me>
#
# Distributed under terms of the GPL-3 license.
#

tor >/tor.log 2>&1 &
trap 'killall tor' EXIT

DNS_PUBLIC=tcp torsocks /opt/monero/monerod \
  --p2p-bind-ip 127.0.0.1 \
  --no-igd \
  --pad-transactions \
  ${INBOUND_ADDRESS:+--anonymous-inbound "$INBOUND_ADDRESS,127.0.0.1:18083,100"}

wait
