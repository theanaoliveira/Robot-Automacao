*** Settings ***
Library         REST    http://localhost/components
Documentation   Deve retornar a lista de componentes cadastrados de acordo com o tipo


*** Variables ***
&{type}         Type=Button

*** Test Cases ***
GET an existing user, notice how the schema gets more accurate
    GET         /api/v1/Components?Type=Button
    Object      response body
    [Teardown]  Output schema