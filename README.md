# Laboratório de Redes com Ubuntu

Projeto prático para estudar fundamentos de redes no Linux, com foco em resolução DNS, conexões TCP, requisições HTTP/HTTPS e captura de pacotes.

## Objetivos

- Consultar registros DNS e entender a resolução de nomes.
- Testar conectividade TCP com serviços remotos.
- Inspecionar cabeçalhos HTTP e HTTPS.
- Capturar e analisar tráfego usando `tcpdump`.
- Praticar comandos Linux, diagnóstico de rede e controle de versão com Git.

## Ferramentas

- Ubuntu Linux (incluindo WSL, quando compatível)
- Bash
- `tcpdump`
- `dig` (pacote `dnsutils`)
- `nc` (pacote `netcat-openbsd`)
- `curl`

## Instalação

Atualize a lista de pacotes e instale as ferramentas:

```bash
sudo apt update
sudo apt install tcpdump dnsutils netcat-openbsd curl -y
```

## Exercícios

### 1. Consultar DNS

Consultar os registros de um domínio:

```bash
dig example.com
dig example.com A +short
```

### 2. Testar uma conexão TCP

Verificar se a conexão à porta HTTPS está acessível:

```bash
nc -vz example.com 443
```

Uma mensagem de sucesso indica que a conexão TCP foi estabelecida; não significa, por si só, que todo o serviço da aplicação está funcionando corretamente.

### 3. Testar HTTP

```bash
curl -I --max-time 10 http://example.com
```

### 4. Testar HTTPS

```bash
curl -I --max-time 10 https://example.com
```

A opção `-I` solicita os cabeçalhos da resposta, sem baixar o corpo da página.

### 5. Capturar pacotes DNS

Crie a pasta para guardar as capturas locais:

```bash
mkdir -p ~/laboratorio-redes/capturas
cd ~/laboratorio-redes
sudo tcpdump -ni any -w capturas/dns.pcap port 53
```

Enquanto a captura estiver ativa, abra outro terminal e execute:

```bash
dig example.com
```

Encerre a captura com `Ctrl+C`. Em seguida, leia os pacotes capturados:

```bash
sudo tcpdump -nn -r capturas/dns.pcap
```

Para limitar a captura a 10 segundos, pode-se usar:

```bash
sudo timeout 10s tcpdump -ni any -w capturas/dns.pcap port 53
```

Gere uma consulta DNS durante esse intervalo em outro terminal. Em ambientes WSL, a interface e o tráfego visíveis podem variar.

## Estrutura do projeto

```text
laboratorio-redes/
├── README.md
├── .gitignore
└── capturas/        # arquivos locais, não enviados ao Git
```

## Segurança e privacidade

- Execute testes apenas em redes e sistemas próprios ou para os quais você tenha autorização.
- Capturas de rede podem conter endereços IP, nomes de domínio e metadados de conexão.
- Os arquivos `.pcap` e `.pcapng` são ignorados pelo Git para evitar publicar dados de tráfego acidentalmente.
- Não inclua senhas, tokens, chaves ou outros segredos no repositório.

## Aprendizados esperados

- Resolução de nomes com DNS.
- Noções de conexão TCP e portas.
- Diferenças entre HTTP e HTTPS.
- Captura e leitura básica de pacotes.
- Uso de Linux e documentação técnica.

## Status

Projeto educacional em desenvolvimento. Os exercícios descritos são instruções de laboratório; adicione resultados e capturas de tela somente depois de executar e validar os testes no seu ambiente.
