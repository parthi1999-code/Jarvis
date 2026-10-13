#!/bin/bash
cd "$(dirname "$0")"
echo
echo "===== JARVIS installer (Mac) ====="
echo

if ! command -v node >/dev/null 2>&1; then
  if command -v brew >/dev/null 2>&1; then
    echo "[1/4] Node.js not found - installing with Homebrew..."
    brew install node || exit 1
  else
    echo "Node.js is not installed. Opening https://nodejs.org -"
    echo "install the LTS version, then double-click INSTALL-MAC.command again."
    open https://nodejs.org
    read -p "Press Enter to close..."
    exit 1
  fi
fi
echo "[1/4] Node.js found: $(node -v)"

if ! command -v claude >/dev/null 2>&1; then
  echo "[2/4] Installing Claude Code..."
  npm install -g @anthropic-ai/claude-code || sudo npm install -g @anthropic-ai/claude-code
else
  echo "[2/4] Claude Code already installed."
fi

echo "[3/4] Installing JARVIS packages (this can take a few minutes)..."
npm install || { echo "npm install failed - see above."; read -p "Press Enter..."; exit 1; }

echo
echo "[4/4] Checking your setup..."
npm run setup
echo
echo "IMPORTANT: if you have never logged in to Claude Code, a login opens now."
echo "Finish the login, then type /exit to come back here."
read -p "Press Enter to continue..."
claude

echo
echo "Starting JARVIS - Chrome will open at http://localhost:5173"
echo "Click INITIALISE, allow the microphone, and say \"Hey Jarvis\"."
echo "Keep this window open while you use JARVIS. Close it to stop."
(for i in $(seq 1 120); do curl -s -o /dev/null http://localhost:5173 && break; sleep 1; done; open -a "Google Chrome" http://localhost:5173 2>/dev/null || open http://localhost:5173) &
npm start
