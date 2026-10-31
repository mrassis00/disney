$css = @'
:root {
  --primary: #1e3a8a;
  --primary-light: #3b82f6;
  --accent: #f59e0b;
  --bg: #f8fafc;
  --card-bg: #ffffff;
  --text: #1e293b;
  --text-muted: #64748b;
  --border: #e2e8f0;
  --highlight: #ecfdf5;
  --highlight-border: #10b981;
}
* { box-sizing: border-box; margin: 0; padding: 0; }
body {
  font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
  line-height: 1.6;
  color: var(--text);
  background-color: var(--bg);
  padding: 20px;
  -webkit-font-smoothing: antialiased;
}
.container {
  max-width: 960px;
  margin: 0 auto;
  background: var(--card-bg);
  padding: 35px 30px;
  border-radius: 16px;
  box-shadow: 0 4px 25px rgba(0, 0, 0, 0.06);
}
h1 { color: var(--primary); font-size: 2.1rem; font-weight: 800; margin-bottom: 12px; letter-spacing: -0.02em; line-height: 1.25; }
h2 { color: #0f172a; font-size: 1.45rem; font-weight: 700; margin-top: 32px; margin-bottom: 14px; padding-bottom: 8px; border-bottom: 2px solid #f1f5f9; letter-spacing: -0.01em; }
h3 { color: #1e3a8a; font-size: 1.2rem; font-weight: 600; margin-top: 22px; margin-bottom: 10px; }
h4 { color: #334155; font-size: 1.05rem; font-weight: 600; margin-top: 16px; margin-bottom: 8px; }
p, li { font-size: 0.98rem; color: #334155; }
p { margin-bottom: 12px; }
ul, ol { margin-left: 24px; margin-bottom: 16px; }
li { margin-bottom: 6px; }
strong { color: #0f172a; font-weight: 600; }
a { color: #2563eb; text-decoration: none; font-weight: 500; }
a:hover { text-decoration: underline; }
hr { border: 0; height: 1px; background: #e2e8f0; margin: 28px 0; }
.table-wrapper { width: 100%; overflow-x: auto; margin: 18px 0; border-radius: 12px; border: 1px solid var(--border); box-shadow: 0 1px 3px rgba(0,0,0,0.03); }
table { width: 100%; border-collapse: collapse; font-size: 0.88rem; text-align: left; }
th { background-color: #f1f5f9; color: #0f172a; font-weight: 700; padding: 12px 14px; border-bottom: 2px solid #cbd5e1; white-space: nowrap; }
td { padding: 11px 14px; border-bottom: 1px solid #f1f5f9; vertical-align: top; }
tr:nth-child(even) td { background-color: #fafbfc; }
tr:hover td { background-color: #f0f7ff; }
blockquote { background-color: #eff6ff; border-left: 4px solid #3b82f6; padding: 14px 18px; border-radius: 0 10px 10px 0; margin: 18px 0; }
blockquote p { color: #1e40af; font-size: 0.95rem; margin: 0; }
code { background: #f1f5f9; padding: 2px 6px; border-radius: 6px; font-size: 0.88em; color: #0f172a; font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace; }
.print-bar { position: fixed; bottom: 20px; right: 20px; z-index: 999; }
.print-btn { background: #2563eb; color: #ffffff; border: none; padding: 12px 20px; border-radius: 30px; font-weight: 600; font-size: 0.95rem; box-shadow: 0 4px 15px rgba(37, 99, 235, 0.4); cursor: pointer; display: flex; align-items: center; gap: 8px; transition: transform 0.15s ease, background 0.15s ease; }
.print-btn:hover { background: #1d4ed8; transform: translateY(-2px); }
@media print {
  body { background: #ffffff; padding: 0; }
  .container { box-shadow: none; padding: 0; max-width: 100%; }
  .print-bar { display: none; }
  table { font-size: 8pt; }
  th, td { padding: 6px 8px; }
  h1 { font-size: 18pt; }
  h2 { font-size: 14pt; margin-top: 16pt; }
  h3 { font-size: 11pt; }
  p, li { font-size: 9pt; }
  tr { page-break-inside: avoid; }
}
@media (max-width: 640px) {
  body { padding: 10px; }
  .container { padding: 20px 14px; border-radius: 12px; }
  h1 { font-size: 1.6rem; }
  h2 { font-size: 1.25rem; }
  table { font-size: 0.8rem; }
  th, td { padding: 8px 10px; }
}
'@

function Convert-MdFile($mdPath, $htmlPath, $pageTitle) {
    $lines = Get-Content -Path $mdPath -Encoding UTF8
    $sb = New-Object System.Text.StringBuilder
    $inTable = $false
    $isHeader = $false
    $inList = $false

    foreach ($line in $lines) {
        $trimmed = $line.Trim()

        if ($trimmed.StartsWith('|') -and $trimmed.EndsWith('|')) {
            if (-not $inTable) {
                [void]$sb.AppendLine('<div class="table-wrapper"><table>')
                $inTable = $true
                $isHeader = $true
            }
            if ($trimmed -match '^\|(\s*:?-+:?\s*\|)+$') {
                $isHeader = $false
                continue
            }
            $cells = $trimmed.Substring(1, $trimmed.Length - 2).Split('|')
            [void]$sb.Append('<tr>')
            foreach ($cell in $cells) {
                $c = $cell.Trim()
                $c = $c -replace '\*\*\*([^\*]+)\*\*\*', '<strong><em>$1</em></strong>'
                $c = $c -replace '\*\*([^\*]+)\*\*', '<strong>$1</strong>'
                $c = $c -replace '\*([^\*]+)\*', '<em>$1</em>'
                $c = $c -replace '\[([^\]]+)\]\(([^)]+)\)', '<a href="$2" target="_blank">$1</a>'
                if ($isHeader) {
                    [void]$sb.Append("<th>$c</th>")
                } else {
                    [void]$sb.Append("<td>$c</td>")
                }
            }
            [void]$sb.AppendLine('</tr>')
            continue
        } else {
            if ($inTable) {
                [void]$sb.AppendLine('</table></div>')
                $inTable = $false
            }
        }

        if ($trimmed -match '^(\*|-)\s+(.+)$') {
            if (-not $inList) {
                [void]$sb.AppendLine('<ul>')
                $inList = $true
            }
            $item = $matches[2]
            $item = $item -replace '\*\*\*([^\*]+)\*\*\*', '<strong><em>$1</em></strong>'
            $item = $item -replace '\*\*([^\*]+)\*\*', '<strong>$1</strong>'
            $item = $item -replace '\*([^\*]+)\*', '<em>$1</em>'
            $item = $item -replace '\[([^\]]+)\]\(([^)]+)\)', '<a href="$2" target="_blank">$1</a>'
            [void]$sb.AppendLine("<li>$item</li>")
            continue
        } else {
            if ($inList) {
                [void]$sb.AppendLine('</ul>')
                $inList = $false
            }
        }

        if ($trimmed -eq '') {
            continue
        }

        if ($trimmed -match '^#\s+(.+)$') {
            [void]$sb.AppendLine("<h1>$($matches[1])</h1>")
            continue
        }
        if ($trimmed -match '^##\s+(.+)$') {
            [void]$sb.AppendLine("<h2>$($matches[1])</h2>")
            continue
        }
        if ($trimmed -match '^###\s+(.+)$') {
            [void]$sb.AppendLine("<h3>$($matches[1])</h3>")
            continue
        }
        if ($trimmed -match '^####\s+(.+)$') {
            [void]$sb.AppendLine("<h4>$($matches[1])</h4>")
            continue
        }
        if ($trimmed -match '^>\s+(.+)$') {
            $quote = $matches[1] -replace '\*\*([^\*]+)\*\*', '<strong>$1</strong>'
            $quote = $quote -replace '\[([^\]]+)\]\(([^)]+)\)', '<a href="$2" target="_blank">$1</a>'
            [void]$sb.AppendLine("<blockquote><p>$quote</p></blockquote>")
            continue
        }
        if ($trimmed -match '^---\s*$') {
            [void]$sb.AppendLine('<hr>')
            continue
        }
        if ($trimmed -match '^!\[([^\]]*)\]\(([^)]+)\)$') {
            [void]$sb.AppendLine("<div style=`"text-align:center; margin:22px 0;`"><img src=`"$($matches[2])`" alt=`"$($matches[1])`" style=`"max-width:100%; border-radius:14px; box-shadow:0 6px 20px rgba(0,0,0,0.12); border:1px solid #e2e8f0;`"><p style=`"font-size:0.85rem; color:#64748b; margin-top:8px; font-weight:500;`">🗺️ $($matches[1])</p></div>")
            continue
        }

        $p = $trimmed -replace '\*\*\*([^\*]+)\*\*\*', '<strong><em>$1</em></strong>'
        $p = $p -replace '\*\*([^\*]+)\*\*', '<strong>$1</strong>'
        $p = $p -replace '\*([^\*]+)\*', '<em>$1</em>'
        $p = $p -replace '\[([^\]]+)\]\(([^)]+)\)', '<a href="$2" target="_blank">$1</a>'
        [void]$sb.AppendLine("<p>$p</p>")
    }

    if ($inTable) { [void]$sb.AppendLine('</table></div>') }
    if ($inList) { [void]$sb.AppendLine('</ul>') }

    $htmlBody = $sb.ToString()
    $fullHtml = @"
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>$pageTitle</title>
  <style>
$css
  </style>
</head>
<body>
  <div class="container">
    $htmlBody
  </div>
  <div class="print-bar">
    <button class="print-btn" onclick="window.print()">
      📄 Salvar como PDF / Imprimir
    </button>
  </div>
</body>
</html>
"@
    Set-Content -Path $htmlPath -Value $fullHtml -Encoding UTF8
    Write-Output "Gerado com sucesso: $htmlPath"
}

$dir = $PSScriptRoot
Convert-MdFile "$dir\resumo_executivo_roteiro_orlando_celular.md" "$dir\resumo_executivo_roteiro_orlando_celular.html" "Orlando 2026 - Resumo Executivo para Celular"
Convert-MdFile "$dir\roteiro_orlando_dezembro_2026_guia_completo.md" "$dir\roteiro_orlando_dezembro_2026_guia_completo.html" "Orlando 2026 - Guia Definitivo e Roteiro Completo"

# Gerar PDFs via Edge/Chrome
function Generate-Pdf($htmlPath, $pdfPath) {
    $browser = $null
    if (Test-Path "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe") {
        $browser = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
    } elseif (Test-Path "C:\Program Files\Google\Chrome\Application\chrome.exe") {
        $browser = "C:\Program Files\Google\Chrome\Application\chrome.exe"
    }

    if ($browser) {
        $tempDir = Join-Path $env:TEMP "browser_pdf_$([System.IO.Path]::GetRandomFileName())"
        New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
        $resolvedHtml = (Resolve-Path $htmlPath).Path.Replace('\', '/')
        $proc = Start-Process -FilePath $browser -ArgumentList "--headless=new", "--disable-gpu", "--no-sandbox", "--no-pdf-header-footer", "--user-data-dir=`"$tempDir`"", "--print-to-pdf=`"$pdfPath`"", "`"file:///$resolvedHtml`"" -PassThru
        $proc.WaitForExit(20000)
        Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
        if (Test-Path $pdfPath) {
            Write-Output "PDF Atualizado: $pdfPath ($((Get-Item $pdfPath).Length) bytes)"
        }
    }
}

Generate-Pdf "$dir\resumo_executivo_roteiro_orlando_celular.html" "$dir\resumo_executivo_roteiro_orlando_celular.pdf"
Generate-Pdf "$dir\roteiro_orlando_dezembro_2026_guia_completo.html" "$dir\roteiro_orlando_dezembro_2026_guia_completo.pdf"
if (Test-Path "$dir\VENDAHOJE.html") {
    Generate-Pdf "$dir\VENDAHOJE.html" "$dir\VENDAHOJE.pdf"
}

