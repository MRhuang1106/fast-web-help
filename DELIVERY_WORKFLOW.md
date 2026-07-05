# Delivery workflow

Use this after a client pays or escrow is funded.

## 1. Create a client workspace

For a one-page website:

```powershell
.\new_client_project.ps1 -ClientSlug client-name -Type starter-page
```

For a README/demo refresh:

```powershell
.\new_client_project.ps1 -ClientSlug client-name -Type readme-refresh
```

Client files are created under:

```text
client-work/client-name/
```

## 2. Confirm materials

Use:

```text
delivery/starter-page/CLIENT_INTAKE.md
```

Keep the first job inside the starter scope:

- one page or one focused fix
- mobile-friendly layout
- clear CTA/contact flow
- source files
- one small revision

## 3. Build first version

For a page, start from:

```text
delivery/starter-page/index.html
```

For a GitHub README, start from:

```text
delivery/readme-refresh/README_TEMPLATE.md
```

## 4. Send handoff

Use the relevant handoff note:

```text
delivery/starter-page/HANDOFF_NOTE.md
delivery/readme-refresh/HANDOFF_NOTE.md
```

## 5. Ask for testimonial

After the revision is accepted:

```text
Thanks. If this first version was useful, could I quote one sentence from you as a testimonial on my service page?
```

