# 90-minute launch runbook

Use this once you authorize publishing the GitHub Pages site.

## 0-10 minutes: publish

Run the local preflight:

```powershell
.\preflight_check.ps1
```

Preview remote actions:

```powershell
.\publish_to_github.ps1 -DryRun
```

Run the publish script from this folder:

```powershell
.\publish_to_github.ps1
```

Expected site:

```text
https://MRhuang1106.github.io/fast-web-help/
```

Check:

- service page loads
- `Open a request` button works
- sample cafe page loads
- sample README refresh page loads

Or run:

```powershell
.\verify_live_site.ps1
```

## 10-25 minutes: open tabs

- Upwork landing page search: https://www.upwork.com/freelance-jobs/landing-pages/
- Upwork website development search: https://www.upwork.com/freelance-jobs/website-development/
- HN Freelancer thread: https://news.ycombinator.com/item?id=48749020
- GitHub repo issues: https://github.com/MRhuang1106/fast-web-help/issues

## 25-55 minutes: apply to 5 Upwork jobs

Use this order:

1. Landing Page Duplicator - WP Expert
2. Simple WordPress Landing Page with Elementor
3. Automotive WordPress Landing Page
4. High-Converting Landing Page Design
5. Build a Modern, High-Converting Landing Page

Copy from:

```text
CUSTOM_APPLICATION_DRAFTS_2026-07-05.md
```

Before submitting each proposal:

- remove sample links if GitHub Pages is not live yet
- keep the opening line specific
- ask only one short question
- do not promise extra integrations
- keep scope to one page or one focused fix

## 55-70 minutes: post on HN

Use:

```text
HN_SEEKING_WORK_POST.md
```

HN replies can be direct but sparse. Post once, then move on.

## 70-90 minutes: direct outreach

Use:

```text
OUTREACH_MESSAGES.md
LEAD_TRACKER.csv
```

Send 10 messages. Each message should mention one specific improvement.

Good targets:

- small creators with many posts but no landing page
- small businesses with outdated menu/service info
- GitHub projects with weak README/demo
- local service providers using only social profiles

## Stop rule

Stop after:

- 5 Upwork proposals
- 1 HN post
- 10 direct messages

Then watch replies and prepare to deliver. The goal is first paid response, not infinite posting.
