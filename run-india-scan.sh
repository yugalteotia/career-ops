#!/bin/bash
# career-ops India scan on this VM.
# Two VM quirks, both verified 2026-11-09:
# 1. Node fetch ignores the VM egress proxy unless CAREER_OPS_TRUST_PROXY_EGRESS=1,
#    and career-ops refuses proxy URLs with credentials over HTTP, so the proxy
#    vars are set here WITHOUT credentials (the proxy accepts them: curl proved it).
# 2. Playwright 1.64.1 wants chromium-1248 but its download fails on this VM,
#    so PDF/browser steps use the already-installed chromium-1243 binary.
export http_proxy=http://hatch-egress-proxy:3128
export https_proxy=http://hatch-egress-proxy:3128
export HTTP_PROXY=http://hatch-egress-proxy:3128
export HTTPS_PROXY=http://hatch-egress-proxy:3128
export CAREER_OPS_TRUST_PROXY_EGRESS=1
export PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH=/home/hatch/.cache/ms-playwright/chromium-1243/chrome-linux64/chrome
cd ~/workspace/career-ops || exit 1
exec node scan.mjs "$@"
