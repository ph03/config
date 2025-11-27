#!/usr/bin/env bash
set -uo pipefail

INTERNAL="eDP-1"

# --- Check Required Tools -----------------------------------------

check_requirements() {
    local missing=()
    
    for tool in wlr-randr jq gum; do
        if ! command -v "$tool" &>/dev/null; then
            missing+=("$tool")
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        echo "Error: Missing required tools: ${missing[*]}" >&2
        echo "" >&2
        echo "Please install the following:" >&2
        for tool in "${missing[@]}"; do
            echo "  - $tool" >&2
        done
        exit 1
    fi
}

check_requirements

# --- CLI Argument Parsing -----------------------------------------

# Parse global options first
while [[ $# -gt 0 ]]; do
    case "$1" in
        --internal)
            if [[ -z "${2:-}" ]]; then
                echo "Error: --internal requires a monitor name" >&2
                exit 1
            fi
            INTERNAL="$2"
            shift 2
            ;;
        --internal=*)
            INTERNAL="${1#*=}"
            shift
            ;;
        *)
            break
            ;;
    esac
done

# --- Helpers ------------------------------------------------------

get_state_json() {
    wlr-randr --json
}

get_monitors() {
    get_state_json | jq -r '
        .[] |
        "\(.name) \(.enabled)"'
}

count_enabled() {
    get_state_json | jq '[.[] | select(.enabled == true)] | length'
}

toggle_monitor() {
    local mon="$1"
    local state="$2"

    # state=="true" → currently ON → turning OFF
    if [[ "$state" == "true" ]]; then
        local enabled_count
        enabled_count=$(count_enabled)

        if [[ "$enabled_count" -le 1 ]]; then
            echo "Cannot disable '$mon': at least one monitor must remain enabled." >&2
            return 1
        fi

        wlr-randr --output "$mon" --off
    else
        wlr-randr --output "$mon" --on
    fi
}

enable_monitor() {
    local mon="$1"
    wlr-randr --output "$mon" --on
}

disable_monitor() {
    local mon="$1"
    local enabled_count
    enabled_count=$(count_enabled)

    if [[ "$enabled_count" -le 1 ]]; then
        echo "Cannot disable '$mon': at least one monitor must remain enabled." >&2
        return 1
    fi

    wlr-randr --output "$mon" --off
}

toggle_all_external() {
    # Check if internal monitor is enabled
    local internal_enabled
    internal_enabled=$(get_state_json | jq -r --arg INTERNAL "$INTERNAL" '
        .[]
        | select(.name == $INTERNAL)
        | .enabled')

    # If internal is off, we cannot disable external monitors
    if [[ "$internal_enabled" != "true" ]]; then
        echo "Cannot disable external monitors: the internal monitor is currently OFF." >&2
        return 1
    fi

    wlr-randr --json | jq -r --arg INTERNAL "$INTERNAL" '
        .[]
        | select(.name != $INTERNAL)
        | .name + " " + (.enabled|tostring)' |
    while read -r mon state; do
        toggle_monitor "$mon" "$state"
    done
}

enable_all_external() {
    wlr-randr --json | jq -r --arg INTERNAL "$INTERNAL" '
        .[]
        | select(.name != $INTERNAL)
        | .name' |
    while read -r mon; do
        enable_monitor "$mon"
    done
}

disable_all_external() {
    # Check if internal monitor is enabled
    local internal_enabled
    internal_enabled=$(get_state_json | jq -r --arg INTERNAL "$INTERNAL" '
        .[]
        | select(.name == $INTERNAL)
        | .enabled')

    # If internal is off, we cannot disable external monitors
    if [[ "$internal_enabled" != "true" ]]; then
        echo "Cannot disable external monitors: the internal monitor is currently OFF." >&2
        return 1
    fi

    wlr-randr --json | jq -r --arg INTERNAL "$INTERNAL" '
        .[]
        | select(.name != $INTERNAL)
        | .name' |
    while read -r mon; do
        disable_monitor "$mon"
    done
}

# Export functions so they're available in subshells
export -f get_state_json
export -f get_monitors
export -f count_enabled
export -f toggle_monitor
export -f enable_monitor
export -f disable_monitor
export -f toggle_all_external
export -f enable_all_external
export -f disable_all_external
export INTERNAL

# --- CLI Argument Handling ----------------------------------------

show_usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS] [COMMAND] [ARGS]

Global Options:
    --internal MONITOR         Override default internal monitor (default: eDP-1)

Commands:
    list                        List all monitors and their status
    toggle-all-external        Toggle all external monitors
    enable-all-external        Enable all external monitors
    disable-all-external       Disable all external monitors
    enable MONITOR [MONITOR...] Enable specified monitor(s)
    disable MONITOR [MONITOR...]Disable specified monitor(s)
    (no args)                  Launch interactive TUI

Examples:
    $(basename "$0") list
    $(basename "$0") --internal HDMI-1 toggle-all-external
    $(basename "$0") enable-all-external
    $(basename "$0") disable-all-external
    $(basename "$0") enable DP-6
    $(basename "$0") --internal DP-1 disable HDMI-1
    $(basename "$0") --internal=DP-1 list
EOF
}

if [[ $# -gt 0 ]]; then
    case "$1" in
        list)
            get_monitors | awk '{printf "%s: %s\n", $1, ($2 == "true" ? "enabled" : "disabled")}'
            exit 0
            ;;
        toggle-all-external)
            toggle_all_external
            exit $?
            ;;
        enable-all-external)
            enable_all_external
            exit $?
            ;;
        disable-all-external)
            disable_all_external
            exit $?
            ;;
        enable)
            shift
            if [[ $# -eq 0 ]]; then
                echo "Error: No monitors specified" >&2
                show_usage
                exit 1
            fi
            for mon in "$@"; do
                echo "Enabling $mon..."
                enable_monitor "$mon"
            done
            exit 0
            ;;
        disable)
            shift
            if [[ $# -eq 0 ]]; then
                echo "Error: No monitors specified" >&2
                show_usage
                exit 1
            fi
            for mon in "$@"; do
                echo "Disabling $mon..."
                disable_monitor "$mon"
            done
            exit 0
            ;;
        -h|--help|help)
            show_usage
            exit 0
            ;;
        *)
            echo "Error: Unknown command '$1'" >&2
            show_usage
            exit 1
            ;;
    esac
fi

# --- TUI Menus ----------------------------------------------------

main_menu() {
    gum choose --header="Select an action" \
        "Toggle single monitor" \
        "Toggle ALL external monitors" \
        "Enable ALL external monitors" \
        "Disable ALL external monitors" \
        "Exit"
}

choose_monitor() {
    local result
    result=$(get_monitors | \
        awk '{printf "%s (%s)\n", $1, $2}' | \
        gum choose --header="Select monitor to toggle (ESC to go back)")
    local exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        return 1
    fi
    echo "$result"
}

# --- Main Loop ----------------------------------------------------

while true; do
    choice=$(main_menu)
    exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        exit 0
    fi

    case "$choice" in
        "Toggle single monitor")
            selected=$(choose_monitor)
            if [[ $? -ne 0 ]]; then
                continue
            fi
            mon=$(echo "$selected" | awk '{print $1}')
            state=$(echo "$selected" | sed 's/.*(\(.*\)).*/\1/')

            gum spin --spinner line --title "Toggling $mon..." -- \
                bash -c "toggle_monitor '$mon' '$state'"
            ;;

        "Toggle ALL external monitors")
            gum spin --spinner globe --title "Toggling all external monitors..." -- \
                bash -c "toggle_all_external"
            ;;

        "Enable ALL external monitors")
            gum spin --spinner globe --title "Enabling all external monitors..." -- \
                bash -c "enable_all_external"
            ;;

        "Disable ALL external monitors")
            gum spin --spinner globe --title "Disabling all external monitors..." -- \
                bash -c "disable_all_external"
            ;;

        "Exit")
            exit 0
            ;;
    esac
done
