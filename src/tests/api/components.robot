*** Settings ***
Resource          /app/resources/main.robot
Test Setup        Dado que eu tenha acesso a tela de components
Documentation     Deve retornar a lista de componentes cadastrados de acordo com o tipo

*** Test Cases ***

Chamar api para obter a lista de components
    Dado que eu selecione o tipo de componente desejado
    Quando clico em pesquisar
    E existem itens cadastrados
    Então devo obter uma lista de componentes cadastrados de acordo com o tipo