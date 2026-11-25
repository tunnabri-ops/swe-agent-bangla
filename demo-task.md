# Demo task — SWE-agent দিয়ে প্রথম issue ঠিক করুন

এই ফাইলের টাস্কটি SWE-agent-এর নিজের ডকুমেন্টেশনের **hello-world উদাহরণ** —
বানানো কিছু নয়, আসল repo আর আসল issue।

## টাস্ক

**Repo:** https://github.com/SWE-agent/test-repo
**Issue:** https://github.com/SWE-agent/test-repo/issues/1

Issue #1 হলো test-repo-র একটা ছোট **syntax error** — SWE-agent শেখার জন্য
আদর্শ প্রথম টাস্ক: ছোট, নিরাপদ, আর ডকুমেন্টেশনে পুরো রানটা দেখানো আছে।

## চালানোর উপায়

```bash
# উপায় ১: রেডি স্ক্রিপ্ট (এই repo-র run-bangla.sh)
export ANTHROPIC_API_KEY="আপনার-কি"   # অথবা .env ফাইলে লিখুন
bash run-bangla.sh

# উপায় ২: কনফিগ ফাইল দিয়ে
sweagent run --config config-bangla.yaml

# উপায় ৩: সরাসরি কমান্ড (docs-এর hello-world কমান্ড)
sweagent run \
  --agent.model.name=claude-sonnet-4-20250514 \
  --agent.model.per_instance_cost_limit=2.00 \
  --env.repo.github_url=https://github.com/SWE-agent/test-repo \
  --problem_statement.github_url=https://github.com/SWE-agent/test-repo/issues/1
```

## সফল হলে কী দেখবেন

1. SWE-agent Docker-এ test-repo ক্লোন করে issue-টা পড়বে।
2. কোড পড়ে syntax error-টা খুঁজে বের করে ঠিক করবে, টেস্ট চালিয়ে দেখবে।
3. শেষে `submit` করবে — patch (পরিবর্তন) আর পুরো trajectory
   `trajectories/` ফোল্ডারে সেভ হবে।

## নিজের repo-তে চেষ্টা করতে চাইলে

`run-bangla.sh`-এ শুধু দুটো ভ্যারিয়েবল বদলান:

```bash
REPO_URL=https://github.com/আপনার-নাম/আপনার-repo \
ISSUE_URL=https://github.com/আপনার-নাম/আপনার-repo/issues/৫ \
bash run-bangla.sh
```

অথবা `config-bangla.yaml`-এ `github_url` দুটো বদলে
`sweagent run --config config-bangla.yaml` চালান।

**খেয়াল:** প্রতিটা রানে API খরচ হয় — `per_instance_cost_limit: 2.00`
মানে একটা issue-তে সর্বোচ্চ $২। ছোট repo আর ছোট issue দিয়ে শুরু করুন।
