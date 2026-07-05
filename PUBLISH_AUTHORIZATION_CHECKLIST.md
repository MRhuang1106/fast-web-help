# Publish authorization checklist

Use this before allowing Codex to publish the repository.

## What publishing will do

Running:

```powershell
.\publish_to_github.ps1
```

will:

- create or reuse the public GitHub repository `MRhuang1106/fast-web-help`
- push the current local `main` branch
- enable GitHub Pages from `main /`
- create the `client-request` label
- publish this site:

```text
https://MRhuang1106.github.io/fast-web-help/
```

## What publishing will not do

- It will not submit Upwork proposals.
- It will not post on Hacker News.
- It will not send direct messages.
- It will not create a payment link.
- It will not mark the overall goal complete.

## Dry run

To preview the publish steps without changing GitHub:

```powershell
.\publish_to_github.ps1 -DryRun
```

## After publishing

Run:

```powershell
.\verify_live_site.ps1
```

Then follow:

```text
LAUNCH_90_MINUTE_RUNBOOK.md
```

## Exact confirmation phrase

Use this when you are ready for Codex to publish:

```text
确认发布
```

After publishing, use this phrase when you want Codex to start drafting or submitting platform posts:

```text
开始投递
```
