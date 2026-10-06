import markdown
import os
import subprocess

CSS_STYLE = """
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

* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

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

h1 {
  color: var(--primary);
  font-size: 2.1rem;
  font-weight: 800;
  margin-bottom: 12px;
  letter-spacing: -0.02em;
  line-height: 1.25;
}

h2 {
  color: #0f172a;
  font-size: 1.45rem;
  font-weight: 700;
  margin-top: 32px;
  margin-bottom: 14px;
  padding-bottom: 8px;
  border-bottom: 2px solid #f1f5f9;
  letter-spacing: -0.01em;
}

h3 {
  color: #1e3a8a;
  font-size: 1.2rem;
  font-weight: 600;
  margin-top: 22px;
  margin-bottom: 10px;
}

h4 {
  color: #334155;
  font-size: 1.05rem;
  font-weight: 600;
  margin-top: 16px;
  margin-bottom: 8px;
}

p, li {
  font-size: 0.98rem;
  color: #334155;
}

p {
  margin-bottom: 12px;
}

ul, ol {
  margin-left: 24px;
  margin-bottom: 16px;
}

li {
  margin-bottom: 6px;
}

strong {
  color: #0f172a;
  font-weight: 600;
}

a {
  color: #2563eb;
  text-decoration: none;
  font-weight: 500;
}

a:hover {
  text-decoration: underline;
}

hr {
  border: 0;
  height: 1px;
  background: #e2e8f0;
  margin: 28px 0;
}

/* Tabelas Ultra Otimizadas */
.table-wrapper {
  width: 100%;
  overflow-x: auto;
  margin: 18px 0;
  border-radius: 12px;
  border: 1px solid var(--border);
  box-shadow: 0 1px 3px rgba(0,0,0,0.03);
}

table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.88rem;
  text-align: left;
}

th {
  background-color: #f1f5f9;
  color: #0f172a;
  font-weight: 700;
  padding: 12px 14px;
  border-bottom: 2px solid #cbd5e1;
  white-space: nowrap;
}

td {
  padding: 11px 14px;
  border-bottom: 1px solid #f1f5f9;
  vertical-align: top;
}

tr:nth-child(even) td {
  background-color: #fafbfc;
}

tr:hover td {
  background-color: #f0f7ff;
}

/* Callouts / Alerts */
blockquote {
  background-color: #eff6ff;
  border-left: 4px solid #3b82f6;
  padding: 14px 18px;
  border-radius: 0 10px 10px 0;
  margin: 18px 0;
}

blockquote p {
  color: #1e40af;
  font-size: 0.95rem;
  margin: 0;
}

/* Badges e tags */
code {
  background: #f1f5f9;
  padding: 2px 6px;
  border-radius: 6px;
  font-size: 0.88em;
  color: #0f172a;
  font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
}

/* Botão Flutuante de Imprimir/Salvar PDF no Celular */
.print-bar {
  position: fixed;
  bottom: 20px;
  right: 20px;
  z-index: 999;
}

.print-btn {
  background: #2563eb;
  color: #ffffff;
  border: none;
  padding: 12px 20px;
  border-radius: 30px;
  font-weight: 600;
  font-size: 0.95rem;
  box-shadow: 0 4px 15px rgba(37, 99, 235, 0.4);
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 8px;
  transition: transform 0.15s ease, background 0.15s ease;
}

.print-btn:hover {
  background: #1d4ed8;
  transform: translateY(-2px);
}

@media print {
  body {
    background: #ffffff;
    padding: 0;
  }
  .container {
    box-shadow: none;
    padding: 0;
    max-width: 100%;
  }
  .print-bar {
    display: none;
  }
  table {
    font-size: 8pt;
  }
  th, td {
    padding: 6px 8px;
  }
  h1 { font-size: 18pt; }
  h2 { font-size: 14pt; margin-top: 16pt; }
  h3 { font-size: 11pt; }
  p, li { font-size: 9pt; }
  tr { page-break-inside: avoid; }
}

@media (max-width: 640px) {
  body {
    padding: 10px;
  }
  .container {
    padding: 20px 14px;
    border-radius: 12px;
  }
  h1 {
    font-size: 1.6rem;
  }
  h2 {
    font-size: 1.25rem;
  }
  table {
    font-size: 0.8rem;
  }
  th, td {
    padding: 8px 10px;
  }
}
"""

def convert_md_to_html(md_path, html_path, title):
    with open(md_path, 'r', encoding='utf-8') as f:
        text = f.read()

    html_content = markdown.markdown(text, extensions=['extra', 'tables', 'toc', 'nl2br'])
    
    # Wrap tables in responsive wrapper
    html_content = html_content.replace('<table>', '<div class="table-wrapper"><table>').replace('</table>', '</table></div>')
    
    full_html = f"""<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{title}</title>
  <style>
{CSS_STYLE}
  </style>
</head>
<body>
  <div class="container">
    {html_content}
  </div>

  <div class="print-bar">
    <button class="print-btn" onclick="window.print()">
      📄 Salvar como PDF / Imprimir
    </button>
  </div>
</body>
</html>
"""
    with open(html_path, 'w', encoding='utf-8') as f:
        f.write(full_html)
    print(f"Gerado: {html_path}")

base_dir = "/Users/mrassis/Desktop/Dev/disney"

# 1. Resumo Executivo para celular
resumo_md = os.path.join(base_dir, "resumo_executivo_roteiro_orlando_celular.md")
resumo_html = os.path.join(base_dir, "resumo_executivo_roteiro_orlando_celular.html")
resumo_pdf = os.path.join(base_dir, "resumo_executivo_roteiro_orlando_celular.pdf")
convert_md_to_html(resumo_md, resumo_html, "Orlando 2026 - Resumo Executivo para Celular")

# 2. Guia Completo Master
completo_md = os.path.join(base_dir, "roteiro_orlando_dezembro_2026_guia_completo.md")
completo_html = os.path.join(base_dir, "roteiro_orlando_dezembro_2026_guia_completo.html")
completo_pdf = os.path.join(base_dir, "roteiro_orlando_dezembro_2026_guia_completo.pdf")
convert_md_to_html(completo_md, completo_html, "Orlando 2026 - Guia Definitivo e Roteiro Completo")

# 3. Gerar PDFs com Chrome Headless
import time

def generate_pdf_chrome(chrome_path, html_path, pdf_path):
    if os.path.exists(pdf_path):
        try:
            os.remove(pdf_path)
        except Exception:
            pass
    user_data_dir = f"/tmp/chrome_pdf_{int(time.time())}_{os.path.basename(pdf_path)}"
    cmd = [
        chrome_path,
        "--headless=new",
        "--disable-gpu",
        "--no-pdf-header-footer",
        f"--user-data-dir={user_data_dir}",
        f"--print-to-pdf={pdf_path}",
        f"file://{html_path}"
    ]
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    start_time = time.time()
    while time.time() - start_time < 15:
        if os.path.exists(pdf_path) and os.path.getsize(pdf_path) > 50000:
            time.sleep(1.5)  # flush do arquivo
            break
        time.sleep(0.5)
    proc.terminate()
    try:
        proc.wait(timeout=2)
    except Exception:
        proc.kill()
    if os.path.exists(pdf_path):
        print(f"PDF Gerado com sucesso ({os.path.getsize(pdf_path)} bytes): {pdf_path}")
    else:
        print(f"Aviso: Não foi possível verificar PDF em {pdf_path}")

chrome_path = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
if os.path.exists(chrome_path):
    print("Gerando PDFs via Chrome Headless...")
    generate_pdf_chrome(chrome_path, resumo_html, resumo_pdf)
    generate_pdf_chrome(chrome_path, completo_html, completo_pdf)

