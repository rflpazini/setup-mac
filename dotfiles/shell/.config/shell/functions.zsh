# functions.zsh — shell helper functions.

# ── Process helpers ──────────────────────────────────────────────────────────
killapp() {
	kill -9 $(ps aux | grep "$1" | grep -v grep | awk '{print $2}')
}

isrunning() {
	ps aux | grep "$1" | grep -v grep | awk '{print $2}'
}

# Show what's listening on a TCP port (default 8080).
whoknocks() {
	local port="${1:-8080}"
	echo "✊🏻 Knocking at port: $port"
	lsof -n -i4TCP:"$port"
}

# ── Secrets / hashing ────────────────────────────────────────────────────────
# Generate a random password of N graph chars (default 20).
password() {
	local count="${1:-20}"
	LC_ALL=C tr -dc "[:graph:]" < /dev/urandom | head -c "$count"
	echo
}

# SHA-256 of a string.
sha256() {
	local input="$1"
	if [[ -z "$input" ]]; then
		echo "Usage: sha256 <string>"
		return 1
	fi
	printf "%s" "$input" | openssl dgst -sha256 | awk '{print $2}'
}

# UUID v4 (prefers uuidgen, lowercased).
uuid() {
	if command -v uuidgen >/dev/null 2>&1; then
		command uuidgen | tr '[:upper:]' '[:lower:]'
	else
		printf '%04x%04x-%04x-%04x-%04x-%04x%04x%04x\n' \
			$RANDOM $RANDOM $RANDOM \
			$(($RANDOM & 0x0fff | 0x4000)) \
			$(($RANDOM & 0x3fff | 0x8000)) \
			$RANDOM $RANDOM $RANDOM
	fi
}

# ── Git helpers ──────────────────────────────────────────────────────────────
git-parent-branch() {
	local current_branch
	current_branch=$(git rev-parse --abbrev-ref HEAD)
	git show-branch -a | awk -F'[]^~[]' '/\*/ && !/'"$current_branch"'/ {print $2; exit}'
}

git-untrack-file() {
	git update-index --assume-unchanged "$1"
}

git-trackfile() {
	git update-index --no-assume-unchanged "$1"
}

# ── Docker helpers ───────────────────────────────────────────────────────────
stopcontainers() {
	docker stop $(docker ps -a -q)
}

killcontainers() {
	echo "⏹  Stopping containers ..."
	docker stop $(docker ps -a -q)
	echo "🚮 Removing containers ..."
	docker rm $(docker ps -a -q)
	echo "✅ Containers removed!"
}

deletedockerimages() {
	echo "🗑  Deleting all docker images ..."
	docker images -q | xargs docker rmi
}

cleardocker() {
	echo "🧹 Clearing docker stuff"
	killcontainers
	deletedockerimages
	echo "🐳 We're ready to rock"
}

# ── Go / Pluto service runners ───────────────────────────────────────────────
run() {
	go run cmd/service/*.go
}

start() {
	local name="$1" environment="$2"
	PLUTO_OPENTELEMETRY_ENDPOINT=http://localhost:5072 \
	PLUTO_APP_ENV="$environment" \
	PLUTO_DEBUG_SERVICE_NAME="service-$name" \
	PLUTO_K8S_NAMESPACE="$environment-service-$name" \
	run
}
