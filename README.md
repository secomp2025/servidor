# SECOMP 2025 - Proxy para Battlesnake e Code-Server

Este projeto fornece um ambiente de desenvolvimento remoto para a competição Battlesnake da SECOMP 2025, utilizando code-server, proxy reverso e configuração via Docker.

## Sobre o Projeto

O objetivo deste ambiente é facilitar a participação na competição Battlesnake, permitindo que os participantes desenvolvam, testem e executem suas snakes remotamente, sem necessidade de configuração local.

## Pré-requisitos

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## Como rodar o projeto

1. **Clone o repositório:**
   ```sh
   git clone https://github.com/secomp2025/servidor.git
   cd secomp
   ```

2. **Copie o arquivo de exemplo de ambiente:**
   ```sh
   cp .env.example .env
   # Edite o arquivo .env conforme necessário
   ```

3. **Construa e suba os containers:**
   ```sh
   docker compose up --build
   ```

4. Certifique-se de ter o Go instalado ([instruções](https://go.dev/doc/install)).
5. No diretório do projeto, execute:
   ```sh
   go run proxy.go
   ```

6. **Acesse o ambiente:**
   Abra o navegador e acesse `http://localhost:3000`

## Estrutura do Projeto

- `compose.yml`: Configuração do Docker Compose
- `Containerfile`: Dockerfile para o code-server
- `proxy.go`: Código do proxy reverso em Go
- `config/`: Arquivos de configuração e dados do code-server
- `workspace/`: Diretório de trabalho dos usuários e onde as cobras devem ser desenvolvidas

## Observações

- O diretório `config/` está no `.gitignore` para evitar o versionamento de dados sensíveis e arquivos grandes.
- Certifique-se de configurar corretamente as variáveis de ambiente no `.env`.
- O ambiente foi preparado para facilitar o desenvolvimento colaborativo durante a SECOMP 2025.

## Sobre a Competição Battlesnake

Battlesnake é uma competição de programação onde os participantes desenvolvem "snakes" (códigos) que competem entre si em um tabuleiro virtual. Para mais informações, acesse: [https://play.battlesnake.com/](https://play.battlesnake.com/)

## Licença

MIT
