# keepalived com failover manual

Para buildar a imagem, execute:

```bash
docker compose build
```

Para executar o ambiente, execute:

```bash
docker compose up
```

Há dois nós nesse cenário, `keepalived_a` e `keepalived_b`. Para testar o failover em
um dos nós, execute:

```bash
# node A
docker compose exec keepalived_a failover

# node B
docker compose exec keepalived_b failover
```

## notas

A partir da versão 1.2.20, não é necessário remover o IP virtual antes de executar o
keepalived. O keepalived irá remover o IP virtual automaticamente antes de iniciar.

<https://github.com/acassen/keepalived/commit/f4c10426ca0a7c3392422c22079f1b71e7d4ebe9>
