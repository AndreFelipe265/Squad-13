# Squad-13

# Sistema Docs

Projeto Laravel para gerenciamento de clientes, templates e documentos, com API autenticada por Laravel Sanctum e assets front-end compilados com Vite.

## Tecnologias

- PHP 8.1 ou superior
- Composer
- Laravel 10
- Laravel Sanctum
- MySQL ou MariaDB
- Node.js 18 ou superior
- NPM
- Vite
- XAMPP, opcional, para rodar Apache/MySQL no Windows

## Estrutura principal

```text
app/Http/Controllers     Controllers da API
app/Models               Models do sistema
database/migrations      Estrutura do banco de dados
routes/api.php           Rotas da API
routes/web.php           Rota web principal
resources/css            CSS usado pelo Vite
resources/js             JavaScript usado pelo Vite
resources/views          Views Blade
```

## Instalacao do ambiente

### 1. Instalar ferramentas

No Windows com XAMPP, confirme que estes itens estao instalados:

- XAMPP com PHP e MySQL
- Composer
- Node.js com NPM

Verifique no terminal:

```powershell
php -v
composer -V
node -v
npm -v
```

### 2. Entrar na pasta do projeto

```powershell
cd C:\xampp\htdocs\sistema-docs
```

### 3. Instalar dependencias do back-end

```powershell
composer install
```

### 4. Instalar dependencias do front-end

```powershell
npm install
```

### 5. Configurar o arquivo `.env`

Se o arquivo `.env` ainda nao existir, crie a partir do exemplo:

```powershell
copy .env.example .env
```

Gere a chave da aplicacao:

```powershell
php artisan key:generate
```

Configure o banco no `.env`. Exemplo usando MySQL local do XAMPP:

```env
APP_NAME="Sistema Docs"
APP_ENV=local
APP_DEBUG=true
APP_URL=http://127.0.0.1:8000

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=sistema_docs
DB_USERNAME=root
DB_PASSWORD=
```

### 6. Criar o banco de dados

Abra o XAMPP e inicie o MySQL. Depois crie um banco chamado `sistema_docs`.

Pelo phpMyAdmin:

```text
http://localhost/phpmyadmin
```

Ou pelo terminal MySQL:

```sql
CREATE DATABASE sistema_docs CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 7. Rodar migrations

```powershell
php artisan migrate
```

Se estiver em ambiente de desenvolvimento e puder apagar os dados atuais, use:

```powershell
php artisan migrate:fresh
```

Atencao: `migrate:fresh` apaga as tabelas existentes antes de recriar tudo.

## Rodando o projeto

Use dois terminais: um para o back-end e outro para o front-end.

### Terminal 1: back-end Laravel

```powershell
cd C:\xampp\htdocs\sistema-docs
php artisan serve --host=127.0.0.1 --port=8000
```

O back-end ficara disponivel em:

```text
http://127.0.0.1:8000
```

A API ficara disponivel em:

```text
http://127.0.0.1:8000/api
```

Se a porta `8000` estiver ocupada:

```powershell
php artisan serve --host=127.0.0.1 --port=8001
```

### Terminal 2: front-end Vite

```powershell
cd C:\xampp\htdocs\sistema-docs
npm run dev
```

Com o Vite rodando, acesse a aplicacao pelo Laravel:

```text
http://127.0.0.1:8000
```

O Vite serve os arquivos de `resources/css/app.css` e `resources/js/app.js` durante o desenvolvimento. Ele nao substitui o servidor Laravel; os dois devem ficar rodando ao mesmo tempo.

## Build de producao do front-end

Para gerar os arquivos finais do front-end:

```powershell
npm run build
```

Depois disso, o Laravel usa os assets compilados da pasta `public/build`.

## Como usar a API

Base URL:

```text
http://127.0.0.1:8000/api
```

### Cadastro de usuario

```http
POST /api/auth/register
Content-Type: application/json
```

```json
{
  "name": "Usuario Teste",
  "email": "usuario@example.com",
  "password": "secret123"
}
```

A resposta retorna um `token`. Use esse token nas proximas requisicoes protegidas:

```http
Authorization: Bearer SEU_TOKEN_AQUI
```

### Login

```http
POST /api/auth/login
Content-Type: application/json
```

```json
{
  "email": "usuario@example.com",
  "password": "secret123"
}
```

### Usuario logado

```http
GET /api/auth/me
Authorization: Bearer SEU_TOKEN_AQUI
```

### Logout

```http
POST /api/auth/logout
Authorization: Bearer SEU_TOKEN_AQUI
```

## Endpoints disponiveis

### Autenticacao

```text
POST   /api/auth/register
POST   /api/auth/login
GET    /api/auth/me
POST   /api/auth/logout
GET    /api/user
```

As rotas `GET /api/auth/me`, `POST /api/auth/logout` e `GET /api/user` exigem token.

### Clientes

```text
GET    /api/clientes
GET    /api/clientes/{id}
POST   /api/clientes
PUT    /api/clientes/{id}
DELETE /api/clientes/{id}
```

Exemplo de cadastro:

```json
{
  "nome": "Cliente Exemplo",
  "cpf": "12345678900",
  "email": "cliente@example.com",
  "telefone": "11999999999",
  "endereco": "Rua Exemplo, 123",
  "cidade": "Sao Paulo",
  "estado": "SP",
  "cep": "01000000"
}
```

### Templates

```text
GET    /api/templates
GET    /api/templates/{id}
POST   /api/templates
PUT    /api/templates/{id}
DELETE /api/templates/{id}
```

Exemplo de cadastro:

```json
{
  "titulo": "Contrato Padrao",
  "conteudo": "<p>Conteudo do template</p>",
  "background_image": "https://exemplo.com/imagem.png"
}
```

### Documentos

```text
GET    /api/documentos
GET    /api/documentos/{id}
POST   /api/documentos
PUT    /api/documentos/{id}
PATCH  /api/documentos/{id}
DELETE /api/documentos/{id}
```

Filtros disponiveis na listagem:

```text
GET /api/documentos?cliente_id=1
GET /api/documentos?template_id=1
GET /api/documentos?status=rascunho
```

Exemplo de cadastro:

```json
{
  "cliente_id": 1,
  "template_id": 1,
  "titulo": "Contrato de Prestacao de Servico",
  "conteudo_final": "<p>Contrato preenchido</p>",
  "status": "rascunho"
}
```

## Testes

Para rodar os testes automatizados:

```powershell
php artisan test
```

## Comandos uteis

Limpar caches do Laravel:

```powershell
php artisan optimize:clear
```

Ver rotas cadastradas:

```powershell
php artisan route:list
```

Ver status das migrations:

```powershell
php artisan migrate:status
```

Parar o servidor Laravel ou o Vite:

```text
Ctrl + C
```

## Problemas comuns

### Erro: `No application encryption key has been specified`

Rode:

```powershell
php artisan key:generate
```

### Erro de conexao com banco

Confira se:

- O MySQL esta iniciado no XAMPP
- O banco `sistema_docs` existe
- As configuracoes `DB_*` do `.env` estao corretas

Depois rode:

```powershell
php artisan migrate
```

### Erro: porta em uso

Use outra porta:

```powershell
php artisan serve --port=8001
```

### Erro: assets ou Vite manifest nao encontrado

Em desenvolvimento, rode:

```powershell
npm run dev
```

Para producao ou quando nao quiser deixar o Vite aberto:

```powershell
npm run build
```

### Erro 401 nas rotas da API

As rotas de clientes, templates e documentos sao protegidas. Faca login ou cadastro primeiro, copie o token retornado e envie:

```http
Authorization: Bearer SEU_TOKEN_AQUI
```

### Onde ver logs

Os erros do Laravel ficam em:

```text
storage/logs/laravel.log
```
