#!/usr/bin/env bash
set -u

# Laboratório de redes: testes básicos de DNS, TCP, HTTP e HTTPS.
# Uso: bash scripts/testar-rede.sh [dominio]
# Exemplo: bash scripts/testar-rede.sh example.com

HOST="${1:-example.com}"
TIMEOUT_SECONDS=10

if ! command -v dig >/dev/null 2>&1; then
  echo "Erro: 'dig' não encontrado. Instale: sudo apt install dnsutils"
  exit 1
fi
if ! command -v nc >/dev/null 2>&1; then
  echo "Erro: 'nc' não encontrado. Instale: sudo apt install netcat-openbsd"
  exit 1
fi
if ! command -v curl >/dev/null 2>&1; then
  echo "Erro: 'curl' não encontrado. Instale: sudo apt install curl"
  exit 1
fi

echo "========================================"
echo " Laboratório de Redes"
echo " Host: $HOST"
echo " Data: $(date '+%Y-%m-%d %H:%M:%S %Z')"
echo "========================================"

echo
echo "[1/4] DNS"
if dig +time=3 +tries=1 "$HOST" A +short; then
  :
else
  echo "Consulta DNS falhou."
fi

echo
echo "[2/4] TCP - porta 443"
if nc -vz -w "$TIMEOUT_SECONDS" "$HOST" 443; then
  echo "Resultado TCP: conexão estabelecida."
else
  echo "Resultado TCP: conexão não estabelecida (pode haver bloqueio ou indisponibilidade)."
fi

echo
echo "[3/4] HTTP - cabeçalhos"
curl -I -sS --max-time "$TIMEOUT_SECONDS" "http://$HOST"   -o /dev/null -w 'Código HTTP: %{http_code}\n'   || echo "Requisição HTTP falhou ou expirou."

echo
echo "[4/4] HTTPS - cabeçalhos"
curl -I -sS --max-time "$TIMEOUT_SECONDS" "https://$HOST"   -o /dev/null -w 'Código HTTPS: %{http_code}\n'   || echo "Requisição HTTPS falhou ou expirou."

echo
echo "Testes finalizados. Resultados dependem da rede e do host testado."
