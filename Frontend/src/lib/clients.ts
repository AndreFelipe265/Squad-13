import {
  deleteCliente,
  getClientesBonsae,
  type BackendCliente,
} from "@/lib/api";

export interface SavedClient {
  id: string;
  name: string;
  values: Record<string, string>;
  updatedAt: string;
}

export const CLIENT_VARIABLES = [
  // Identificação
  { id: "nome_cliente",     key: "nome_cliente",     label: "Nome Completo",        icon: "user" },
  { id: "nome_social",      key: "nome_social",      label: "Nome Social",          icon: "user" },
  { id: "tipo_pessoa",      key: "tipo_pessoa",      label: "Tipo de Pessoa (PF/PJ)", icon: "user" },
  { id: "cpf",              key: "cpf",              label: "CPF",                  icon: "id-card" },
  { id: "cnpj",             key: "cnpj",             label: "CNPJ",                 icon: "id-card" },
  { id: "rg",               key: "rg",               label: "RG",                   icon: "id-card" },
  { id: "orgao_emissor",    key: "orgao_emissor",    label: "Órgão Emissor (RG)",   icon: "id-card" },
  { id: "uf_emissor",       key: "uf_emissor",       label: "UF do Órgão Emissor",  icon: "id-card" },
  { id: "data_nascimento",  key: "data_nascimento",  label: "Data de Nascimento",   icon: "calendar" },
  { id: "nacionalidade",    key: "nacionalidade",    label: "Nacionalidade",        icon: "map-pin" },
  { id: "naturalidade",     key: "naturalidade",     label: "Naturalidade",         icon: "map-pin" },

  // Estado civil e família
  { id: "estado_civil",     key: "estado_civil",     label: "Estado Civil",         icon: "user" },
  { id: "profissao",        key: "profissao",        label: "Profissão",            icon: "user" },
  { id: "escolaridade",     key: "escolaridade",     label: "Escolaridade",         icon: "user" },
  { id: "renda_mensal",     key: "renda_mensal",     label: "Renda Mensal",         icon: "user" },
  { id: "nome_mae",         key: "nome_mae",         label: "Nome da Mãe",          icon: "user" },
  { id: "nome_pai",         key: "nome_pai",         label: "Nome do Pai",          icon: "user" },

  // Documentos complementares
  { id: "titulo_eleitor",   key: "titulo_eleitor",   label: "Título de Eleitor",    icon: "id-card" },
  { id: "pis",              key: "pis",              label: "PIS",                  icon: "id-card" },

  // Contato
  { id: "telefone",         key: "telefone",         label: "Telefone",             icon: "phone" },
  { id: "telefone2",        key: "telefone2",        label: "Telefone 2",           icon: "phone" },
  { id: "email",            key: "email",            label: "E-mail",               icon: "mail" },

  // Endereço (tabela addresses)
  { id: "endereco",         key: "endereco",         label: "Logradouro",           icon: "map-pin" },
  { id: "numero",           key: "numero",           label: "Número",               icon: "map-pin" },
  { id: "complemento",      key: "complemento",      label: "Complemento",          icon: "map-pin" },
  { id: "bairro",           key: "bairro",           label: "Bairro",               icon: "map-pin" },
  { id: "cidade",           key: "cidade",           label: "Cidade",               icon: "building" },
  { id: "estado",           key: "estado",           label: "Estado (UF)",          icon: "map-pin" },
  { id: "cep",              key: "cep",              label: "CEP",                  icon: "map-pin" },
];

export function mapBackendCliente(cliente: BackendCliente): SavedClient {
  const name = cliente.nome || `Cliente ${cliente.id}`;

  return {
    id: String(cliente.id),
    name,
    updatedAt: cliente.updated_at || cliente.created_at || new Date().toISOString(),
    values: {
      // Identificação
      nome_cliente:    cliente.nome || "",
      nome_social:     cliente.nome_social || "",
      tipo_pessoa:     cliente.tipo_pessoa || "",
      cpf:             cliente.cpf || "",
      cnpj:            cliente.cnpj || "",
      rg:              cliente.rg || "",
      orgao_emissor:   cliente.orgao_emissor || "",
      uf_emissor:      cliente.uf_emissor || "",
      data_nascimento: cliente.data_nascimento || "",
      nacionalidade:   cliente.nacionalidade || "",
      naturalidade:    cliente.naturalidade || "",

      // Família e perfil
      estado_civil:    cliente.estado_civil || "",
      profissao:       cliente.profissao || "",
      escolaridade:    cliente.escolaridade || "",
      renda_mensal:    cliente.renda_mensal || "",
      nome_mae:        cliente.nome_mae || "",
      nome_pai:        cliente.nome_pai || "",

      // Documentos complementares
      titulo_eleitor:  cliente.titulo_eleitor || "",
      pis:             cliente.pis || "",

      // Contato
      telefone:        cliente.telefone || "",
      telefone2:       cliente.telefone2 || "",
      email:           cliente.email || "",

      // Endereço
      endereco:        cliente.endereco || "",
      numero:          cliente.numero || "",
      complemento:     cliente.complemento || "",
      bairro:          cliente.bairro || "",
      cidade:          cliente.cidade || "",
      estado:          cliente.estado || "",
      cep:             cliente.cep || "",
    },
  };
}

export async function getClientList(): Promise<SavedClient[]> {
  const clientes = await getClientesBonsae();
  return clientes.map(mapBackendCliente);
}

export async function deleteClient(id: string) {
  await deleteCliente(id);
}