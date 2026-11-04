# 🔖 BETA 2 — Baseline do Plano Orlando 2026

**Data do congelamento:** 04/11/2026 (20h40, horário de Brasília)
**Tag Git:** `Beta2` (anteriores: `Beta1`, `beta`, `v-beta`)
**Estado:** plano fechado, **ingressos e seguro AINDA NÃO comprados**.

## Como restaurar este ponto
```
git checkout Beta2                  # ver o estado congelado
git checkout -b retomada Beta2      # trabalhar a partir dele
```

---

## 1. Fotografia do plano em Beta 2

### Já feito / quitado
| Item | Status | Dados |
| :--- | :--- | :--- |
| ✈️ Voos | Emitidos (milhas) | Ida United GRU→IAD→TPA (11-12/12, UA 860 + UA 1140, pouso TPA 20h30). Volta Delta MCO→ATL→GRU (31/12, DL 1742 + DL 0269). Assentos marcados. |
| 🏨 Hotel | Reservado (Booking) | Homewood Suites by Hilton Orlando-I-Drive Convention Center, 6435 Westwood Blvd, 19 noites (12–31/12), **US$ 2.914,07** em dólar no débito Chase. Café e estacionamento grátis. |
| 🚗 Carro | **Quitado no cartão de crédito brasileiro** | Rentcars/AVIS, voucher `X4X9T9M`, Chevrolet Traverse ou similar (7 lugares), retirada TPA 12/12, devolução MCO 31/12 às 15h30, CDW + terceiros US$ 1M, drop fee incluso, 2º condutor grátis. |
| 🎂 Jantar 13/12 | Confirmado | Hard Rock Cafe Universal CityWalk, 19h00, OpenTable `#1713319`, mesa p/ 4 (aniversário do Marcelo). |
| 💰 Caixa | Disponível | US$ 18.856,83 no Chase (venda Schwab de 29/10, via ACH). |
| 🛒 Carrinho duplo | Pré-reservado | Lin Rentals, Baby Jogger Summit X3 Double, US$ 130. Booster da Isabela despachado grátis no voo. |
| 🛣️ Pedágios | Estratégia definida | SunPass PRO Portable (US$ 14,95 + US$ 10), recusar e-Toll da AVIS. I-4 TPA→Orlando é sem pedágio. |
| 📱 App | No ar | https://mrassis00.github.io/disney/ — `index.html` = `app_roteiro_orlando.html` (hash idêntico), com aba 🚗 Carro, checklist de 22 etapas, voos, hotel, Waze, manual embutido. |

### Decidido, a executar (nada comprado ainda)
| # | Produto | Canal definido | Data | Estimativa 4 pax |
| :-: | :--- | :--- | :--- | :--- |
| 1 | Disney 4-Day Base (1 parque/dia) | Undercover Tourist | início 16/12 | ~US$ 2.868,14 |
| 2 | Universal 2-Park 1-Day Park-to-Park | Undercover Tourist (ou site oficial) | 14/12 | ~US$ 808 |
| 3 | Universal Epic Universe 1-Day | Site oficial Universal | 18/12 | ~US$ 648 |
| 4 | SeaWorld 1-Day | Undercover Tourist | 27/12 | ~US$ 339 |
| 5 | Seguro IMG Patriot America Plus (US$ 1M/pessoa) | imglobal.com | 11/12/2026–01/01/2027 | ~US$ 210 **total da família** (~US$ 52,50 por pessoa) |

Pagamento: débito Chase em USD. **Total ≈ US$ 4.873,14.**

### Calendário de parques (vigente)
| Data | Parque |
| :--- | :--- |
| 14/12 (seg) | Universal Studios + Islands (Hogwarts Express) |
| 16/12 (qua) | Magic Kingdom |
| 18/12 (sex) | Epic Universe |
| 19/12 (sáb) | Animal Kingdom |
| 21/12 (seg) | Hollywood Studios |
| 22/12 (ter) | EPCOT |
| 27/12 (dom) | SeaWorld |

Dias 15, 17, 20 e 23–26 e 28–30 são descanso/compras/passeios leves.

---

## 2. O que foi feito antes da troca de LLM (66 interações + esta sessão)

**Fase 1 — Pesquisa e roteiro base (Interações 1–15)**
- Revalidação do roteiro p/ hotel fora da Disney; comparativo de hotéis do Booking (Genius 2).
- Perfil da família definido (Marcelo, Thalita, Miguel 7a, Isabela 5a); aniversário do Marcelo em 13/12 (corrigido na Int. 9).
- Guia completo + resumo executivo p/ celular, em MD, HTML e PDF; criação do `history.md`.
- Inclusão do SeaWorld; regra "1 dia de parque, 1 dia de descanso"; NASA/Cabo Canaveral incluída e depois removida (Int. 19).

**Fase 2 — Seguros, carro e logística (Interações 16–37)**
- Análise de cobertura do Booking/RentalCover, AVIS e proteções mínimas; comparação de locadoras e das 10 opções da Rentcars; Tahoe vs Traverse e consumo.
- Compra das passagens e do hotel; checklist de pendências.
- Primeiro marco **Beta** (Int. 28): tag Git `beta`.
- Validação dos links da Rentcars, cruzamento com horários dos voos, reserva do carro (`X4X9T9M`) e voucher salvo.
- Reserva Hard Rock Cafe no OpenTable (`#1713319`).

**Fase 3 — Estratégia financeira (Interações 38–49)**
- Definição: ingressos no débito Chase (dólar com dólar), sem Santander/Inter; estratégia mista (Undercover p/ Disney).
- Carrinho duplo (Lin Rentals) e booster grátis; seguro saúde IMG Patriot escolhido, com protocolo de urgência a partir do hotel; SunPass PRO.
- Análise Schwab → venda de US$ 18.856,83 em 29/10 → ACH p/ Chase; hotel fechado em US$ 2.914,07 (Cenário 1).

**Fase 4 — Roteiro detalhado por parque (Interações 50–57)**
- Int. 50: versão Beta oficial consolidada em 29/10 (tag `v-beta`).
- Comparação dos Planos A/B/C/D; Universal movida p/ segunda 14/12.
- Cotações Undercover (Disney/Universal/SeaWorld) e atualização financeira.
- Roteiro minuto a minuto do Magic Kingdom e replicado nos demais parques, com mapas.
- Decisão de abolir PDFs de roteiro (só HTML + imagens).

**Fase 5 — App web (Interações 58–66)**
- Congelamento **Beta1**; app PWA offline-first com localStorage, mapas dos 7 parques, Service Worker.
- Git remoto + GitHub Pages no ar.
- Checklist Master de 22 etapas com percentual no topo; módulo de voos/boarding pass; conexão IAD + museu Udvar-Hazy; hotel Homewood corrigido; links Waze; manual embutido.
- Protocolo `restart` registrado (Int. 64–65).
- Int. 66: reserva do carro integrada (aba 🚗 Carro, card no dashboard, checklist 14 e 21).

**Sessão de 04/11 (antes desta baseline)**
- Retomada via `restart`; comparação Undercover Tourist × site oficial (preço, reembolso, remarcação) para Disney, Universal, Epic e SeaWorld.
- Auditoria de datas p/ compra em novembro e janela do ingresso Disney.
- Esclarecimento do seguro: US$ ~210 é o total da família, não por pessoa; mantido o **IMG Patriot** (decisão do usuário).
- Revisão final de riscos antes da compra.

---

## 3. ⚠️ Pontos em aberto / não verificados (conferir ANTES de pagar)

1. **Preços**: todos os valores de ingressos e seguro são estimativas do plano, não cotações ao vivo.
2. **Reembolso de 95% da Undercover Tourist**: foi afirmado nas respostas, mas não confirmado nos termos atuais. Ler a política no checkout.
3. **Validade do ingresso Disney de 4 dias (janela de 7 dias)**: o plano depende disso para EPCOT em 22/12. Confirmar a regra no checkout. Se a validade for menor, o 4º dia quebra.
4. **Magic Kingdom 16/12 sem festa de Natal**: não verificado no calendário oficial.
5. **Epic Universe na Undercover**: a indisponibilidade foi suposição; checar os dois canais.
6. **Inconsistência financeira**: o carro foi pago no cartão BR, mas o app e o guia ainda mostram "Custos US$ 10.492,21 / Saldo livre US$ 8.364,62" como se tudo saísse do Chase. Se o carro (US$ 1.116,23) sair da conta, o saldo livre no Chase seria ≈ **US$ 9.480,85**. Não corrigido neste baseline.
7. **Guia (item 9)** lista Epic como "cotado Undercover", mas a recomendação é o site oficial.
8. **Interação 65 do `history.md`** traz datas antigas (AK 14/12, EPCOT 18/12, MK 21/12, HS 22/12, Universal 16/12). **Valem as datas da seção 1 acima.**
9. **`sw.js`** ainda usa cache `orlando-2026-v3`; subir para `v4` ajuda o app instalado a pegar a aba Carro mais rápido.
10. Endereços, telefones e horários citados no app (museu, clínicas, hospitais) não foram reconferidos em fonte oficial nesta sessão.
