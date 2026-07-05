# Follow-up system

Use this after publishing and applying.

## Commands

Show summary:

```powershell
.\sales_pipeline.ps1 -Action summary
```

List all leads:

```powershell
.\sales_pipeline.ps1 -Action list
```

Show leads due for follow-up:

```powershell
.\sales_pipeline.ps1 -Action due
```

Add a lead:

```powershell
.\sales_pipeline.ps1 -Action add -Source Upwork -LeadName "Sample landing page job" -Url "https://client-job-url.invalid" -Offer "One-page landing page" -Price "$49" -Notes "Good scope"
```

Mark a proposal sent:

```powershell
.\sales_pipeline.ps1 -Action touch -Id 1 -Status applied -FollowupDays 2 -Notes "Proposal sent"
```

Mark a reply:

```powershell
.\sales_pipeline.ps1 -Action touch -Id 1 -Status replied -FollowupDays 1 -Notes "Asked for portfolio"
```

Mark a win:

```powershell
.\sales_pipeline.ps1 -Action touch -Id 1 -Status won -FollowupDays 0 -Notes "Paid starter task"
```

## Status values

- planned
- applied
- messaged
- replied
- quoted
- paid_pending
- won
- lost
- rejected

## Daily routine

1. Check due follow-ups.
2. Reply to anyone who responded.
3. Send at most 5 new proposals.
4. Send at most 10 direct messages.
5. Stop once one client pays or escrow is funded.

## Follow-up templates

After proposal:

```text
Quick follow-up: I can keep this as a small first version with one CTA, mobile layout, and one revision. If you share the content/reference, I can confirm scope quickly.
```

After reply:

```text
Thanks. Based on that, I would keep the starter scope to one page / one focused fix. I can do the first usable version within 24 hours after materials and payment/escrow are ready.
```

After quote:

```text
Just checking if you want me to reserve time for this. The starter scope is still $49 and includes one small revision.
```
