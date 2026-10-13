#!/bin/bash
cd "$(dirname "$0")"
(for i in $(seq 1 120); do curl -s -o /dev/null http://localhost:5173 && break; sleep 1; done; open -a "Google Chrome" http://localhost:5173 2>/dev/null || open http://localhost:5173) &
npm start
