-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 09/05/2026 às 18:04
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `sistemas_documentos`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `clientes`
--

CREATE TABLE `clientes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `nome` varchar(255) NOT NULL,
  `cpf` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telefone` varchar(255) DEFAULT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `cidade` varchar(255) DEFAULT NULL,
  `estado` varchar(2) DEFAULT NULL,
  `cep` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `clientes`
--

INSERT INTO `clientes` (`id`, `user_id`, `nome`, `cpf`, `email`, `telefone`, `endereco`, `cidade`, `estado`, `cep`, `created_at`, `updated_at`) VALUES
(15, 44, 'july', '655481846354', 'july@gmail.com', '7991587854', 'rua rua wiurnk1u', 'aracaju', 'SE', '49001-000', '2026-05-04 22:01:36', '2026-05-09 01:42:40'),
(18, 54, 'valtson', '07998118916548', 'valtson@gmail.com', '79991541600', 'rua rua capela', 'capela', 'SE', '49001-000', '2026-05-09 17:19:53', '2026-05-09 17:20:17'),
(19, 56, 'Jose', '065826481', 'jose@gmail.com', '79991541600', 'rua jose', 'Aracaju', 'SE', '49001-000', '2026-05-09 17:41:27', '2026-05-09 17:41:51');

-- --------------------------------------------------------

--
-- Estrutura para tabela `documentos`
--

CREATE TABLE `documentos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cliente_id` bigint(20) UNSIGNED NOT NULL,
  `template_id` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `conteudo_final` longtext NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'rascunho',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `documentos`
--

INSERT INTO `documentos` (`id`, `user_id`, `cliente_id`, `template_id`, `titulo`, `conteudo_final`, `status`, `created_at`, `updated_at`) VALUES
(13, 44, 15, 14, 'Novo documento july', '<p>oijuly kjfbsbfsfujuly@gmail.com aslkfnosiorua rua wiurnk1u lfsndffaracaju </p>', 'rascunho', '2026-05-09 01:42:51', '2026-05-09 01:42:51'),
(15, 54, 18, 16, 'Novo documento valtson', '<p>templete de casamento no civil no nome de valtson no cpf 07998118916548  no telefone 79991541600 </p>', 'rascunho', '2026-05-09 17:21:37', '2026-05-09 17:21:37'),
(16, 56, 19, 17, 'Novo documento Jose', '<p>criação de um novo documento no nome de Jose no cpf de 065826481 no endereço rua jose na cidade Aracaju </p>', 'rascunho', '2026-05-09 17:43:01', '2026-05-09 17:43:01');

-- --------------------------------------------------------

--
-- Estrutura para tabela `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2026_04_06_161905_create_clientes_table', 1),
(6, '2026_04_06_161910_create_templates_table', 1),
(7, '2026_04_06_161915_create_documentos_table', 1),
(8, '2026_04_06_190840_add_campos_to_clientes_table', 2),
(9, '2026_04_28_180500_add_user_id_to_document_resources', 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(17, 'App\\Models\\User', 36, 'api-token', 'cd89c2b00a1846c6534e4ad15642ed5a7dfd8c101d0d28956e667ad29b87514b', '[\"*\"]', '2026-05-04 21:55:14', NULL, '2026-05-04 21:52:38', '2026-05-04 21:55:14'),
(20, 'App\\Models\\User', 42, 'api-token', '443244f522d83bf6f79ead6fcf6abcc1b11851108280b96ca56cd28503bf25df', '[\"*\"]', '2026-05-04 21:54:44', NULL, '2026-05-04 21:54:44', '2026-05-04 21:54:44'),
(22, 'App\\Models\\User', 44, 'api-token', 'dc71a163105e2ebba7d9f50d712c3a036351904e64f88ade894def47b8952149', '[\"*\"]', '2026-05-04 22:02:19', NULL, '2026-05-04 22:01:31', '2026-05-04 22:02:19'),
(24, 'App\\Models\\User', 45, 'bonsae-front', 'a6e8a06e001813389d375049128295639633f039f619cc7400f18c7cc4d0bda1', '[\"*\"]', '2026-05-09 01:39:22', NULL, '2026-05-09 01:39:22', '2026-05-09 01:39:22'),
(25, 'App\\Models\\User', 46, 'bonsae-front', '503944f30ff8150deb835e8392e023a9577f02db4fee40e4d4a17fa8684112d3', '[\"*\"]', NULL, NULL, '2026-05-09 01:39:35', '2026-05-09 01:39:35'),
(26, 'App\\Models\\User', 46, 'bonsae-front', '4aa6dd10259618c6993971aaf784318201f67971f975fdc7c4ad2b8482d677d1', '[\"*\"]', NULL, NULL, '2026-05-09 01:39:36', '2026-05-09 01:39:36'),
(30, 'App\\Models\\User', 50, 'bonsae-front', '5d9aebd33cc9078842ac5f42106c5a9f02839b4c317d8f63661701aacaf44fb5', '[\"*\"]', '2026-05-09 01:49:26', NULL, '2026-05-09 01:49:26', '2026-05-09 01:49:26'),
(31, 'App\\Models\\User', 51, 'bonsae-front', 'fb72185a55e7f324ffcf0ac5307dd79449831357c9ff8efdc2f85a44286bddcb', '[\"*\"]', '2026-05-09 01:49:27', NULL, '2026-05-09 01:49:26', '2026-05-09 01:49:27'),
(32, 'App\\Models\\User', 52, 'bonsae-front', 'd9b788cbc1a876efc6e892ef4fb3dda1efd2d7f390d633b413aba05bcfddd95a', '[\"*\"]', '2026-05-09 01:50:24', NULL, '2026-05-09 01:50:23', '2026-05-09 01:50:24'),
(33, 'App\\Models\\User', 53, 'bonsae-front', 'c9b8166f8caf8360097b88332199bf309d2dc0c289899057afad3ea8ba72c87a', '[\"*\"]', '2026-05-09 01:50:24', NULL, '2026-05-09 01:50:23', '2026-05-09 01:50:24'),
(36, 'App\\Models\\User', 56, 'bonsae-front', '9488f623b3e5d28eba9e1fae4ff90dced56b1f79b3bad158127ed3448978fc7d', '[\"*\"]', '2026-05-09 17:43:01', NULL, '2026-05-09 17:41:19', '2026-05-09 17:43:01');

-- --------------------------------------------------------

--
-- Estrutura para tabela `templates`
--

CREATE TABLE `templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `titulo` varchar(255) NOT NULL,
  `conteudo` longtext NOT NULL,
  `background_image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `templates`
--

INSERT INTO `templates` (`id`, `user_id`, `titulo`, `conteudo`, `background_image`, `created_at`, `updated_at`) VALUES
(14, 43, 'templede 2', '<p>oi<span key=\"nome_cliente\" label=\"Nome do Cliente\" data-variable=\"nome_cliente\" data-label=\"Nome do Cliente\" class=\"variable-badge\" contenteditable=\"false\">Nome do Cliente</span> kjfbsbfsfu<span key=\"email\" label=\"E-mail\" data-variable=\"email\" data-label=\"E-mail\" class=\"variable-badge\" contenteditable=\"false\">E-mail</span> aslkfnosio<span key=\"endereco\" label=\"Endereco\" data-variable=\"endereco\" data-label=\"Endereco\" class=\"variable-badge\" contenteditable=\"false\">Endereco</span> lfsndff<span key=\"cidade\" label=\"Cidade\" data-variable=\"cidade\" data-label=\"Cidade\" class=\"variable-badge\" contenteditable=\"false\">Cidade</span> </p>', NULL, '2026-05-04 21:59:32', '2026-05-04 21:59:32'),
(16, 54, 'casamento', '<p>templete de casamento no civil no nome de <span key=\"nome_cliente\" label=\"Nome do Cliente\" data-variable=\"nome_cliente\" data-label=\"Nome do Cliente\" class=\"variable-badge\" contenteditable=\"false\">Nome do Cliente</span> no cpf <span key=\"cpf_cnpj\" label=\"CPF\" data-variable=\"cpf_cnpj\" data-label=\"CPF\" class=\"variable-badge\" contenteditable=\"false\">CPF</span>  no telefone <span key=\"telefone\" label=\"Telefone\" data-variable=\"telefone\" data-label=\"Telefone\" class=\"variable-badge\" contenteditable=\"false\">Telefone</span> </p>', NULL, '2026-05-09 17:21:24', '2026-05-09 17:21:24'),
(17, 56, 'criação de documento', '<p>criação de um novo documento no nome de <span key=\"nome_cliente\" label=\"Nome do Cliente\" data-variable=\"nome_cliente\" data-label=\"Nome do Cliente\" class=\"variable-badge\" contenteditable=\"false\">Nome do Cliente</span> no cpf de <span key=\"cpf_cnpj\" label=\"CPF\" data-variable=\"cpf_cnpj\" data-label=\"CPF\" class=\"variable-badge\" contenteditable=\"false\">CPF</span> no endereço <span key=\"endereco\" label=\"Endereco\" data-variable=\"endereco\" data-label=\"Endereco\" class=\"variable-badge\" contenteditable=\"false\">Endereco</span> na cidade <span key=\"cidade\" label=\"Cidade\" data-variable=\"cidade\" data-label=\"Cidade\" class=\"variable-badge\" contenteditable=\"false\">Cidade</span> </p>', NULL, '2026-05-09 17:42:50', '2026-05-09 17:42:50');

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(43, 'richard', 'richardnndd@gmail.com', NULL, '$2y$12$LWkmr8Ao5MG3EVrlEXOZJuck7gMRZlvSeq4oIq7qDP8WvsGb9W3XS', NULL, '2026-05-04 21:57:35', '2026-05-04 21:57:35'),
(44, 'leticia', 'leticia12@gmail.com', NULL, '$2y$12$4AdTpstSJfZ8ntGjWGpcfuaSBJ5VFe.JlXdu8Vm492CC6wbcmj9CG', NULL, '2026-05-04 22:01:31', '2026-05-04 22:01:31'),
(48, 'gabriel', 'gabriel@gmail.com', NULL, '$2y$12$VgJwlPG7FFpcRidNVa4zw.sLCGMHfMDv3IqGzdkTszyWt6Cw.rdyK', NULL, '2026-05-09 01:41:41', '2026-05-09 01:41:41'),
(49, 'RICHARD LOBO', 'richardnndd345@gmail.com', NULL, '$2y$12$q.D9am198J4u5C0KBJTYXOGPZ3vjX6YxFOV8ujIBTKIXVEG1cYkGu', NULL, '2026-05-09 01:44:35', '2026-05-09 01:44:35'),
(54, 'RICHARD LOBO 11', 'richardnnfg@gmail.com', NULL, '$2y$12$YnVYWBFSYgmpBpg1WUWzHu/vCmIMggoUDXJhe99WjknRulLg639OK', NULL, '2026-05-09 17:19:38', '2026-05-09 17:19:38'),
(55, 'gabriel', 'gabrie34l@gmail.com', NULL, '$2y$12$kc0cyBK8yv9NPtbKr7LaUOVAZdPb0hrvnLgW36GPt878S195Bl.BO', NULL, '2026-05-09 17:24:48', '2026-05-09 17:24:48'),
(56, 'RICHARD LOBO', 'richardnndd4535@gmail.com', NULL, '$2y$12$Ms16bnqUeUqDhZ/m/yjRw.y8GF4oRzihxIGMfqi3wSeucyU07wZzS', NULL, '2026-05-09 17:41:19', '2026-05-09 17:41:19');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clientes_user_id_foreign` (`user_id`);

--
-- Índices de tabela `documentos`
--
ALTER TABLE `documentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documentos_cliente_id_foreign` (`cliente_id`),
  ADD KEY `documentos_template_id_foreign` (`template_id`),
  ADD KEY `documentos_user_id_foreign` (`user_id`);

--
-- Índices de tabela `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Índices de tabela `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Índices de tabela `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Índices de tabela `templates`
--
ALTER TABLE `templates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `templates_user_id_foreign` (`user_id`);

--
-- Índices de tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de tabela `documentos`
--
ALTER TABLE `documentos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de tabela `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de tabela `templates`
--
ALTER TABLE `templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `clientes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `documentos`
--
ALTER TABLE `documentos`
  ADD CONSTRAINT `documentos_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `documentos_template_id_foreign` FOREIGN KEY (`template_id`) REFERENCES `templates` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `documentos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `templates`
--
ALTER TABLE `templates`
  ADD CONSTRAINT `templates_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
