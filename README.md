# SWE-agent Bangla — AI দিয়ে GitHub Issue ঠিক করুন

Bangla-ready SWE-agent setup.

## কী আছে / What is inside

- `run-bangla.sh` — রেডি রান কমান্ড: মডেল, খরচের সীমা, repo আর issue URL এক জায়গায়; ডিফল্টে docs-এর hello-world উদাহরণ (test-repo issue #1) চালায়।
- `config-bangla.yaml` — একই রানের YAML কনফিগ: `sweagent run --config config-bangla.yaml`।
- `demo-task.md` — হাতে-কলমে প্রথম টাস্ক: আসল repo, আসল issue, সফল হলে কী দেখবেন।

## যা ঠিক করা হয়েছে / What was fixed

- Docs অনেক পাতায় ছড়ানো — hello-world কমান্ড, config ফাইল, API key — এখানে সব এক জায়গায়, Bangla কমেন্টসহ।
- উদাহরণে খরচের সীমা, Docker চেক আর `.env` থেকে key নেওয়ার ধাপ আলাদা করে বলা নেই — স্ক্রিপ্টে সেগুলো আগেই ঢোকানো আছে, যাতে প্রথম রানেই আটকে না যান।
- **খেয়াল:** নতুন কাজ এখন mini-swe-agent-এ হচ্ছে, নতুন ব্যবহারকারীদের সেটাই সুপারিশ করা হয়। এই repo SWE-agent (1.x) দিয়ে বানানো।

## ব্যবহার / How to use

```bash
# 1. Install + Docker চালু করুন
pip install sweagent

# 2. API key দিন (.env ফাইলে বা export করে — স্ক্রিপ্টে key লিখবেন না)
echo 'ANTHROPIC_API_KEY=আপনার-কি' > .env
#    অথবা GPT-4o চাইলে: OPENAI_API_KEY=... আর MODEL=gpt-4o

# 3. চালান (ডিফল্ট: test-repo issue #1, খরচের সীমা $2)
bash run-bangla.sh

#    অথবা কনফিগ ফাইল দিয়ে:
sweagent run --config config-bangla.yaml
```

নিজের repo-তে চালাতে `run-bangla.sh`-এর `REPO_URL` আর `ISSUE_URL` বদলান —
বিস্তারিত `demo-task.md`-এ।

সব ফ্ল্যাগ যাচাই করা হয়েছে docs থেকে (2026-11-25):
`sweagent run --agent.model.name=... --agent.model.per_instance_cost_limit=... --env.repo.github_url=... --problem_statement.github_url=...`
