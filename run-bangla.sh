#!/usr/bin/env bash
# run-bangla.sh — SWE-agent দিয়ে GitHub issue ঠিক করার রেডি কমান্ড
# Run a SWE-agent fix for a GitHub issue, with a Bangla problem statement.
#
# Flags verified against the upstream docs (https://swe-agent.com/latest/usage/hello_world/):
#   sweagent run --agent.model.name=... --agent.model.per_instance_cost_limit=...
#     --env.repo.github_url=... --problem_statement.github_url=...
#   and: sweagent run --config <file>  (see config-bangla.yaml)
#
# Needs: SWE-agent installed (pip install sweagent) + Docker running,
#   and one API key: ANTHROPIC_API_KEY (Claude) or OPENAI_API_KEY (GPT).
#   Put the key in a .env file or export it — never paste it into this script.

set -euo pipefail

# ---- বদলানোর জায়গা (edit these) -------------------------------------------
MODEL="${MODEL:-claude-sonnet-4-20250514}"   # or: gpt-4o (needs OPENAI_API_KEY)
COST_LIMIT="${COST_LIMIT:-2.00}"             # dollars, per issue
REPO_URL="${REPO_URL:-https://github.com/SWE-agent/test-repo}"
ISSUE_URL="${ISSUE_URL:-https://github.com/SWE-agent/test-repo/issues/1}"
# ----------------------------------------------------------------------------

if ! command -v sweagent >/dev/null 2>&1; then
    echo "sweagent পাওয়া যায়নি। ইনস্টল করুন: pip install sweagent" >&2
    echo "sweagent not found. Install it with: pip install sweagent" >&2
    exit 1
fi

if ! docker info >/dev/null 2>&1; then
    echo "Docker চলছে না — SWE-agent ডিফল্টভাবে Docker sandbox-এ কোড চালায়।" >&2
    echo "Docker is not running — SWE-agent runs code in a Docker sandbox by default." >&2
    exit 1
fi

# .env থাকলে সেখান থেকে API key নিন (docs-এ বলা উপায়)
if [ -f .env ]; then
    set -a
    # shellcheck disable=SC1091
    . ./.env
    set +a
fi

echo "চালানো হচ্ছে / Running SWE-agent"
echo "  model : $MODEL"
echo "  repo  : $REPO_URL"
echo "  issue : $ISSUE_URL"
echo "  limit : \$$COST_LIMIT"

sweagent run \
    --agent.model.name="$MODEL" \
    --agent.model.per_instance_cost_limit="$COST_LIMIT" \
    --env.repo.github_url="$REPO_URL" \
    --problem_statement.github_url="$ISSUE_URL"

echo
echo "শেষ! রেজাল্ট (trajectory + patch) বর্তমান ফোল্ডারের trajectories/ এ আছে।"
echo "Done! The trajectory and patch are saved under trajectories/ in this folder."
