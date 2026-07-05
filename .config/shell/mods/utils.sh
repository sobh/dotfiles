# Load Environment Variables from .env file, or /dev/stdin
loadenv() {
	set -a
	. "${1:-/dev/stdin}"
	set +a
}
