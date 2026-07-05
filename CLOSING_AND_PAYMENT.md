# Closing and payment playbook

Use this after someone replies, opens a GitHub issue, or shows interest from Upwork/HN/outreach.

## Goal

Turn interest into a small paid scope with low risk:

- clear deliverable
- fixed price
- first version within 24 hours
- one small revision
- payment before or through escrow

## Default offer

Starter task:

- One-page site, link-in-bio, README/demo refresh, or small website fix
- First usable version in 24 hours after materials are received
- One small revision
- Source files included
- Price: $49

## Reply when someone opens a request

```text
Thanks, this looks like a good fit for a starter task.

I can do a first usable version within 24 hours for $49. Scope would include:

- one page or one focused fix
- mobile-friendly layout
- clear CTA/contact flow
- source files
- one small revision

To start, please send the text/assets/reference link you want me to use. Once scope is confirmed, I can begin after payment is handled through your preferred safe method.
```

## If they ask for a lower price

```text
I can keep it at $49 by keeping the scope tight: one page, one CTA, one revision. If we need extra sections, integrations, or more revisions, I can quote that separately after the first version is live.
```

## If they ask for proof

```text
Here is the service page and current GitHub profile:

Service page: https://MRhuang1106.github.io/fast-web-help/
GitHub: https://github.com/MRhuang1106

For this first task, I can also send a short structure outline before starting so you can confirm the direction.
```

## Payment options

Use whichever option the client already trusts:

- Upwork escrow if the lead came from Upwork
- Fiverr order if the lead came from Fiverr
- PayPal invoice
- Stripe Payment Link
- Wise
- local transfer if you personally know the client

For direct clients, ask for either:

- 50% upfront and 50% after the preview link is delivered
- 100% upfront for $49 starter tasks
- escrow through a platform if trust is low

## Do not accept

- account recovery jobs
- requests to bypass platform rules
- unpaid "test tasks" that are equivalent to the whole job
- tasks that explicitly forbid AI assistance while you are using Codex
- broad fixed-price jobs with unclear scope

## Delivery message

```text
First version is ready:

Live preview: [link]
Source files: [repo or zip link]

Included:
- [item 1]
- [item 2]
- [item 3]

Please send the one small revision you want me to handle. If everything looks good, I would also appreciate a short testimonial I can quote on my service page.
```

## After payment

Use `DELIVERY_WORKFLOW.md` to create the client workspace and handoff files.

For a one-page task:

```powershell
.\new_client_project.ps1 -ClientSlug client-name -Type starter-page
```

For a README/demo refresh:

```powershell
.\new_client_project.ps1 -ClientSlug client-name -Type readme-refresh
```
