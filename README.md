# 🚚 Sistema de Frete

## Cobertura de Teste - SimpleCov
![image](https://user-images.githubusercontent.com/92264330/170708155-7d363d2d-03d6-48d0-a1c5-4ec9dd8a5128.png)

<p align="right">
  <a href='https://github.com/philipeleandro/Freight-System/blob/main/README_EN.md'>English</a>
</p>

## 📖 Descrição
Sistema frete é uma plataforma para gerenciamento de entregas de produtos que pode ser utilizada por empresas

- **Admin:** Cadastra empresas, cria ordens de serviços e consulta preços
- **Usuário Comum:** Cadastra veículos, configura preços e prazos das empresas, acompanha as ordens de serviços.
- **Visitante:** Consulta status de entrega

## 🚀 Instrução
Use o seguinte comando para clonar o repositório:
```sh
git clone https://github.com/philipeleandro/Freight-System
```
Rode o comando 
`bundle install`

## 🖥️ O que fazer no Sistema de Frete?
O sistema de Frete possibilita acesso para visitantes, usuários das transportadoras cadastradas e os administradores do sistema, no qual as funções do sistema disponíveis para cada um destes são distintas.

### 🧑‍💼 Administradores
Estes possuem domínio de emails diferente para login, nesse sistema sendo o domínio `sistemadeentregas.com.br`. Os admins desempenham funções de cadastrar novas transportadoras ao sistema com as informações de cada empresa, além de criar ordens de serviço encaminhando diretamente para a transportadora desejada. No sistema também é possivel para o administrador verificar as ordens de serviço existentes e fazer consulta de preços com os valores cadastrados de cada transportadora para em seguida criar a ordem de serviço direcionada a transportadora optada.

### 👩‍🦰 Usuários das transportadoras
Os usuários das transportadoras possuem acesso mediante a criação de contas nos quais os domínios de email de usuário coincidam com os domínios informados pelas empresas, no caso o email com domínio `exemplo.com.br` poderia dar acesso a uma empresa que tivesse esse mesmo domínio informado na sua criação no Sistema de Frete.

Dentre as funções disponíveis, tem-se `Serviços` no qual irá retornar as ordens de serviço vínculadas com a transportadora. Nesta é mostrado um código único de 15 caracteres, mostrando o status da ordem de serviço. Caso, o status seja `Pendente`, o usuário poderá aceitar ou recusar a ordem de serviço, logo, se aceita, o usuário terá a opção de `atualização de rota do pedido`, no qual poderá informar o local, hora e data de onde encontra-se o pedido.

No sistema de Frete tem disponível as funções de `Cadastrar Carro`, no qual o usuário irá prover com as informações dos carros de serviços; a função de `Cadastrar Preço` é onde o usuário da transportadora preencherá com os intervalos de peso(kg), volume(m³) e os valores por km a serem cobrados; já `Cadastrar Prazo`, o usuário irá informar os valores de distância(km) e o dias úteis que compreendem aquele intervalo de entrega.

Para os usuários das transportadoras também é possível fazer a verificação dos preços e prazos de entrega já cadastrados pelas transportadoras por meio das funções `Consulta de Preço` e `Consulta de Prazo`, respectivamente.

### 👨🏾‍🦱 Visitantes
Para usuários não logados, ou seja, usuário que não são reconhecidos como administradores ou usuários das transportadoras, na página inicial do sistema é possível através de uma barra de pesquisa, procurar por informações de ordens de serviço utilizando os códigos únicos de 15 caracteres gerados na criação da ordem de serviço.

